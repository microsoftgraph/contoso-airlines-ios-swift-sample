//
//  GraphManager.swift
//  FlightSchedule
//
//  Created by Jason Johnston on 3/8/19.
//  Copyright © 2019 Jason Johnston. All rights reserved.
//

import Foundation
import MSGraphClientSDK

class GraphManager {
    static let instance = GraphManager()
    
    private let authProvider: GraphAuthProvider?
    private let client: MSHTTPClient?
    
    private init() {
        authProvider = GraphAuthProvider()
        client = MSClientFactory.createHTTPClient(with: authProvider)
    }
    
    public func getMe(completion: @escaping(GraphUser?, Error?)->Void) {
        let meRequest = NSMutableURLRequest(url: URL(string: "\(MSGraphBaseURL)/me")!)
        let meDataTask = MSURLSessionDataTask(request: meRequest, client: client, completion: {
            (data: Data?, response: URLResponse?, graphError: Error?) in
            guard let meData = data, graphError == nil else {
                completion(nil, graphError)
                return
            }
            
            print("getMe returned \(meData)")
            do {
                let me = try JSONSerialization.jsonObject(with: meData, options: JSONSerialization.ReadingOptions.mutableContainers)
                print("Parsed: \(me)")
                let user = GraphUser(json: (me as? [String: Any])!)
                print("Model: \(String(describing: user))")
                completion(user, nil)
            } catch {
                completion(nil, error)
            }
        })
        
        meDataTask?.execute()
    }
    
    public func getUserPhoto(userId: String, completion: @escaping(UIImage?, Error?)->Void) {
        let photoRequest = NSMutableURLRequest(url: URL(string: "\(MSGraphBaseURL)/users/\(userId)/photo/$value")!)
        let photoDataTask = MSURLSessionDataTask(request: photoRequest, client: client, completion: {
            (data: Data?, response: URLResponse?, graphError: Error?) in
            guard let photoData = data, graphError == nil else {
                completion(nil, graphError)
                return
            }
            
            print("getUserPhoto returned \(photoData)")
            let image = UIImage(data: photoData)
            completion(image, nil)
        })
        
        photoDataTask?.execute()
    }
    
    public func getUserPhotosBatch(userIds: [String], completion: @escaping([UIImage?]?, Error?)->Void) {
        // If only one, just make a normal call
        if userIds.count == 1 {
            getUserPhoto(userId: userIds[0], completion: {
                (image: UIImage?, error: Error?) in
                let images = [image]
                completion(images, error)
            })
            return
        }
        
        // Create batch requestd
        var batchSteps = [MSBatchRequestStep]()
        var stepId = 1
        
        userIds.forEach {
            (userId: String) in
            let photoRequest = NSMutableURLRequest(url: URL(string: "/users/\(userId)/photo/$value")!)
            let photoBatchStep = MSBatchRequestStep(id: "\(stepId)", request: photoRequest, andDependsOn: nil)
            batchSteps.append(photoBatchStep!)
            stepId = stepId+1
        }
        
        do {
            let batchRequestContent = try MSBatchRequestContent(requests: batchSteps)
            
            let batchRequest = NSMutableURLRequest(url: URL(string: "\(MSGraphBaseURL)/$batch")!)
            batchRequest.httpMethod = "POST"
            batchRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let bodyData = try JSONSerialization.data(withJSONObject: batchRequestContent.getBatchRequestContent(), options: JSONSerialization.WritingOptions.prettyPrinted)
            batchRequest.httpBody = bodyData
            
            let batchTask = MSURLSessionDataTask(request: batchRequest, client: client) {
                (data: Data?, response: URLResponse?, error: Error?) in
                guard let responseData = data, error == nil else {
                    print("Batch returned error: \(error!)")
                    completion(nil, error)
                    return
                }
                
                do {
                    let responseContent = try MSBatchResponseContent(batchResponseData: responseData, options: JSONSerialization.ReadingOptions.mutableContainers)
                    
                    var images = [UIImage?]()
                    
                    for i in 1...userIds.count {
                        let imageResponse = responseContent.getResponseById("\(i)") as NSDictionary?
                        let imageStatus = imageResponse?["status"] as! Int
                        if (imageStatus == 200) {
                            let imageData = Data(base64Encoded: imageResponse?["body"] as! String)
                            if (imageData != nil) {
                                let image = UIImage(data: imageData!)
                                images.append(image)
                            } else {
                                images.append(nil)
                            }
                        } else {
                            let imageError = imageResponse?["body"] as! NSDictionary?
                            print("Error from request \(i): \(String(describing: imageError))")
                            images.append(nil)
                        }
                    }
                    
                    completion(images, nil)
                    
                } catch {
                    print("Error reading response: \(error)")
                    completion(nil, error)
                }
            }
            
            batchTask?.execute()
        } catch {
            print("Error creating batch request: \(error)")
        }
    }
}

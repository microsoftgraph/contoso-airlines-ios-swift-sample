//
//  GraphManager.swift
//  FlightSchedule
//
//  Copyright (c) Microsoft. All rights reserved.
//  Licensed under the MIT license. See LICENSE.txt in the project root for license information.
//

import Foundation
import MSGraphClientSDK
import MSGraphMSALAuthProvider
import MSGraphClientModels

class GraphManager {
    static let instance = GraphManager()
    
    private let client: MSHTTPClient?
    
    private init() {
        let authProvider = MSALAuthenticationProvider(
            publicClientApplication: AuthenticationManager.instance.getPublicClientApp(),
            andScopes: AppConfig.scopes)
        
        client = MSClientFactory.createHTTPClient(with: authProvider)
    }
    
    // Gets the logged-in user
    public func getMe(completion: @escaping(MSGraphUser?, Error?)->Void) {
        // GET /me
        let meRequest = NSMutableURLRequest(url: URL(string: "\(MSGraphBaseURL)/me")!)
        let meDataTask = MSURLSessionDataTask(request: meRequest, client: client, completion: {
            (data: Data?, response: URLResponse?, graphError: Error?) in
            guard let meData = data, graphError == nil else {
                completion(nil, graphError)
                return
            }
            
            do {
                let user = try MSGraphUser(data: meData)
                completion(user, nil)
            } catch {
                completion(nil, error)
            }
        })
        
        meDataTask?.execute()
    }
    
    // Gets a single user's photo
    public func getUserPhoto(userId: String, completion: @escaping(UIImage?, Error?)->Void) {
        // GET /users/{id}/photo/$value
        let photoRequest = NSMutableURLRequest(url: URL(string: "\(MSGraphBaseURL)/users/\(userId)/photo/$value")!)
        let photoDataTask = MSURLSessionDataTask(request: photoRequest, client: client, completion: {
            (data: Data?, response: URLResponse?, graphError: Error?) in
            guard let photoData = data, graphError == nil else {
                completion(nil, graphError)
                return
            }
            
            let image = UIImage(data: photoData)
            completion(image, nil)
        })
        
        photoDataTask?.execute()
    }
    
    // Gets multiple user photos in a batch
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
        
        // Create batch request
        var batchSteps = [MSBatchRequestStep]()
        var stepId = 1
        
        userIds.forEach {
            // Create a batch step and add to the batch
            (userId: String) in
            // GET /users/{id}/photo/$value
            let photoRequest = NSMutableURLRequest(url: URL(string: "/users/\(userId)/photo/$value")!)
            let photoBatchStep = MSBatchRequestStep(id: "\(stepId)", request: photoRequest, andDependsOn: nil)
            batchSteps.append(photoBatchStep!)
            stepId += 1
        }
        
        do {
            let batchRequestContent = try MSBatchRequestContent(requests: batchSteps)
            
            // POST /$batch
            let batchRequest = NSMutableURLRequest(url: URL(string: "\(MSGraphBaseURL)/$batch")!)
            batchRequest.httpMethod = "POST"
            batchRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let bodyData = try JSONSerialization.data(withJSONObject: batchRequestContent.getBatchRequestContent() as Any, options: JSONSerialization.WritingOptions.prettyPrinted)
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
                        // Find each response in the batch response and map the
                        // returned image to the user ID
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
    
    // Gets the logged-in user's calendar view
    public func getCalendarView(start: Date, end: Date, completion: @escaping([MSGraphEvent]?, Error?)->Void) {
        let dateFormatter = ISO8601DateFormatter()
        let startISO = dateFormatter.string(from: start)
        let endISO = dateFormatter.string(from: end)
        
        // GET /me/calendarview?startDateTime={start}&endDateTime={end}&
        // $select=subject,location,start,end&
        // $filter=categories/any(a:a eq 'Assigned Flight')&
        // $expand=extensions($filter=id eq 'com.contoso.flightData')&
        // $orderby=start/dateTime
        let queryString = "startDateTime=\(startISO)&endDateTime=\(endISO)&$select=subject,location,start,end&$filter=categories/any(a:a+eq+'Assigned+Flight')&$expand=extensions($filter=id+eq+'com.contoso.flightData')&orderby=start/dateTime"
        let requestUrlString = "\(MSGraphBaseURL)/me/calendarview?\(queryString)"
        let requestUrl = URL(string: requestUrlString)
        
        let calendarViewRequest = NSMutableURLRequest(url: requestUrl!)
        let calendarViewDataTask = MSURLSessionDataTask(request: calendarViewRequest, client: client, completion: {
            (data: Data?, response: URLResponse?, graphError: Error?) in
            guard let calendarViewData = data, graphError == nil else {
                completion(nil, graphError)
                return
            }
            
            do {
                let eventsCollection = try MSCollection(data: calendarViewData)
                var eventArray: [MSGraphEvent] = []
                
                eventsCollection.value.forEach({
                    (rawEvent: Any) in
                    guard let eventDict = rawEvent as? [String: Any] else {
                        return
                    }
                    
                    let event = MSGraphEvent(dictionary: eventDict)
                    print("Event: \(String(describing: event!.subject))")
                    eventArray.append(event!)
                })
                completion(eventArray, nil)
            } catch {
                completion(nil, error)
            }
        })
        
        calendarViewDataTask?.execute()
    }
    
    // Looks up multiple users by id and returns their user objects
    public func getUsersByIds(identifiers: [String], completion: @escaping([MSGraphUser?]?, Error?)->Void) {
        // Create batch request
        var batchSteps = [MSBatchRequestStep]()
        var stepId = 1
        
        if identifiers.count == 0 {
            completion(nil, nil)
            return
        }
        
        identifiers.forEach {
            (email: String) in
            // GET /users/{email}
            let userRequest = NSMutableURLRequest(url: URL(string: "/users/\(email)")!)
            let userBatchStep = MSBatchRequestStep(id: "\(stepId)", request: userRequest, andDependsOn: nil)
            batchSteps.append(userBatchStep!)
            stepId += 1
        }
        
        do {
            let batchRequestContent = try MSBatchRequestContent(requests: batchSteps)
            
            // POST /$batch
            let batchRequest = NSMutableURLRequest(url: URL(string: "\(MSGraphBaseURL)/$batch")!)
            batchRequest.httpMethod = "POST"
            batchRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let bodyData = try JSONSerialization.data(withJSONObject: batchRequestContent.getBatchRequestContent() as Any, options: JSONSerialization.WritingOptions.prettyPrinted)
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
                    
                    var users = [MSGraphUser?]()
                    
                    for i in 1...identifiers.count {
                        // Find each response in the batch response and map the
                        // returned user in the array
                        let userResponse = responseContent.getResponseById("\(i)") as NSDictionary?
                        let userStatus = userResponse?["status"] as! Int
                        if (userStatus == 200) {
                            let userJson = userResponse?["body"] as? [String: Any]
                            let user = MSGraphUser(dictionary: userJson)
                            users.append(user)
                        } else {
                            let userError = userResponse?["body"] as! NSDictionary?
                            print("Error from request \(i): \(String(describing: userError))")
                            users.append(nil)
                        }
                    }
                    
                    completion(users, nil)
                    
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

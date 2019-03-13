//
//  ProfilePhotoUtil.swift
//  FlightSchedule
//
//  Created by Jason Johnston on 3/11/19.
//  Copyright © 2019 Jason Johnston. All rights reserved.
//

import Foundation
import MSGraphClientSDK
import UIKit

class ProfilePhotoUtil {
    static let instance = ProfilePhotoUtil()
    
    private init() {
        
    }
    
    public func getUserPhoto(userId: String, completion: @escaping(UIImage?, Error?)->Void) {
        let imagePath = "\(NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true))/\(userId).png"
        let imageUrl = URL(fileURLWithPath: imagePath)
        
        let imageData = try? Data(contentsOf: imageUrl)
        if (imageData != nil) {
            let image = UIImage(data: imageData!, scale: UIScreen.main.scale)
            completion(image, nil)
            return
        }
        
        // Get the photo from Graph
        GraphManager.instance.getUserPhoto(userId: userId) {
            (image: UIImage?, error: Error?) in
            guard error == nil else {
                completion(image, error)
                return
            }
            // Save image to cache
            try? image?.pngData()?.write(to: imageUrl)
            completion(image, error)
        }
    }
    
    public func getUsersPhotos(userIds: [String], completion: @escaping([UIImage?], Error?)->Void) {
        var images = [UIImage?](repeating: nil, count: userIds.count)
        var photosToFetch = [String]()
        
        // Load any cached images
        for (index, userId) in userIds.enumerated() {
            let imagePath = "\(NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true))/\(userId).png"
            let imageUrl = URL(fileURLWithPath: imagePath)
            
            let imageData = try? Data(contentsOf: imageUrl)
            if (imageData != nil) {
                images[index] = UIImage(data: imageData!, scale: UIScreen.main.scale)
            } else {
                // User's image not in cache, add to fetch list
                photosToFetch.append(userId)
            }
        }
        
        // Fetch remaining user photos from Graph
        
    }
}

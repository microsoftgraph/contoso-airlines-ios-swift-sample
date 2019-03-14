//
//  ProfilePhotoUtil.swift
//  FlightSchedule
//
//  Copyright (c) Microsoft. All rights reserved.
//  Licensed under the MIT license. See LICENSE.txt in the project root for license information.
//

import Foundation
import MSGraphClientSDK
import UIKit

class ProfilePhotoUtil {
    static let instance = ProfilePhotoUtil()
    private let cachePath: String
    
    private init() {
        cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
    }
    
    // Get a single user photo by checking the cached copies first
    // If not in cache, make a Graph call to download and cache the photo
    public func getUserPhoto(userId: String, completion: @escaping(UIImage?, Error?)->Void) {
        let imagePath = "\(cachePath)/\(userId).png"
        let imageUrl = URL(fileURLWithPath: imagePath)
        
        let imageData = try? Data(contentsOf: imageUrl)
        if (imageData != nil) {
            print("Loaded cached photo: \(imagePath)")
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
            print("Caching photo: \(imagePath)")
            try? image?.pngData()?.write(to: imageUrl)
            completion(image, error)
        }
    }
    
    // Get multiple users' photos by checking the cached copies first
    // For any not in cache, make a batch call to Graph to download them
    // and save in the cache
    public func getUsersPhotos(userIds: [String], completion: @escaping([UIImage?], Error?)->Void) {
        var images = [UIImage?](repeating: nil, count: userIds.count)
        var photosToFetch: [Int: String] = [:]
        
        // Load any cached images
        for (index, userId) in userIds.enumerated() {
            let imagePath = "\(cachePath)/\(userId).png"
            let imageUrl = URL(fileURLWithPath: imagePath)
            
            let imageData = try? Data(contentsOf: imageUrl)
            if (imageData != nil) {
                print("Loaded cached photo: \(imagePath)")
                images[index] = UIImage(data: imageData!, scale: UIScreen.main.scale)
            } else {
                // User's image not in cache, add to fetch list
                photosToFetch[index] = userId
            }
        }
        
        if photosToFetch.count == 0 {
            completion(images, nil)
            return
        }
        
        // Fetch remaining user photos from Graph
        print("Need to fetch \(photosToFetch.count) photos")
        let fetchUserIds = Array(photosToFetch.values)
        GraphManager.instance.getUserPhotosBatch(userIds: fetchUserIds) {
            (photos: [UIImage?]?, error:Error?) in
            guard let userPhotos = photos, error == nil else {
                print("Error retrieving photos: \(String(describing: error))")
                // Return the cached images at least
                completion(images, nil)
                return
            }
            
            var userPhotoIndex = 0
            for (index, userId) in photosToFetch {
                let photo = userPhotos[userPhotoIndex]
                if (photo != nil) {
                    let imagePath = "\(self.cachePath)/\(userId).png"
                    let imageUrl = URL(fileURLWithPath: imagePath)
                    print("Caching photo: \(imagePath)")
                    try? photo!.pngData()?.write(to: imageUrl)
                }
                images[index] = userPhotos[userPhotoIndex]
                userPhotoIndex = userPhotoIndex + 1
            }
            
            completion(images, nil)
        }
    }
}

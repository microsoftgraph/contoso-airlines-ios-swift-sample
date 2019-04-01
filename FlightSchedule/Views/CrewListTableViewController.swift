//
//  CrewListTableViewController.swift
//  FlightSchedule
//
//  Copyright (c) Microsoft. All rights reserved.
//  Licensed under the MIT license. See LICENSE.txt in the project root for license information.
//

import UIKit
import MSGraphClientModels

class CrewListTableViewController: UITableViewController {

    var crewIds: [String]? {
        didSet {
            guard let userIds = crewIds else {
                return
            }
            
            // Get the crew members' photos
            GraphManager.instance.getUserPhotosBatch(userIds: userIds) {
                (images: [UIImage?]?, error: Error?) in
                if (error != nil) {
                    print("Error getting crew photos: \(String(describing: error))")
                }
                self.crewPhotos = images
                
                // Get the crew members' profiles (for title, phone number, etc.)
                GraphManager.instance.getUsersByIds(identifiers: self.crewIds!, completion: {
                    (users: [MSGraphUser?]?, error: Error?) in
                    if (error != nil) {
                        print("Error getting crew members: \(String(describing: error))")
                    }
                    self.crewMembers = users
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                })
            }
        }
    }
    
    var crewPhotos: [UIImage?]?
    var crewMembers: [MSGraphUser?]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return crewMembers?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CrewListCell", for: indexPath) as! CrewListViewCell
        
        let crewMember = crewMembers![indexPath.row]
        
        cell.crewMemberName = crewMember?.displayName
        cell.crewMemberTitle = crewMember?.jobTitle ?? "Flight Attendant"
        cell.crewMemberMobileNumber = crewMember?.mobilePhone
        
        let crewPhoto = crewPhotos![indexPath.row]
        
        cell.crewMemberPhoto = crewPhoto ?? UIImage(named: "default-photo")

        return cell
    }
}

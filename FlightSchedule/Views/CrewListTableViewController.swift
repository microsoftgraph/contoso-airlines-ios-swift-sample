//
//  CrewListTableViewController.swift
//  FlightSchedule
//
//  Created by Jason Johnston on 3/27/19.
//  Copyright © 2019 Jason Johnston. All rights reserved.
//

import UIKit
import MSGraphClientModels

class CrewListTableViewController: UITableViewController {

    var crewIds: [String]? {
        didSet {
            guard let userIds = crewIds else {
                return
            }
            
            GraphManager.instance.getUserPhotosBatch(userIds: userIds) {
                (images: [UIImage?]?, error: Error?) in
                if (error != nil) {
                    print("Error getting crew photos: \(String(describing: error))")
                }
                self.crewPhotos = images
                
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    

}

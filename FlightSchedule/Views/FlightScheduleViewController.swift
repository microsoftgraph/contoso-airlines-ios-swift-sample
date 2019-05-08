//
//  FlightScheduleViewController.swift
//  FlightSchedule
//
//  Copyright (c) Microsoft. All rights reserved.
//  Licensed under the MIT license. See LICENSE.txt in the project root for license information.
//

import Foundation
import UIKit
import MSGraphClientModels

class FlightScheduleViewController: UITableViewController {
    
    private let tableCellIdentifier = "ScheduleCell"
    var flights: [MSGraphEvent]?

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
        return flights?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellIdentifier, for: indexPath) as! FlightScheduleViewCell

        let flight = flights?[indexPath.row]
        
        // Configure the cell...
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        cell.flightName = flight?.subject
        cell.departureTime = formatter.string(from: Date(from: flight!.start!))
        cell.indexForCell = indexPath
        
        return cell
    }
    
    public func setFlights(flights: [MSGraphEvent]) {
        self.flights = flights
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let detailVC = segue.destination as? FlightDetailViewController {
            let tappedCell = sender as? FlightScheduleViewCell
            
            detailVC.flight = flights?[(tappedCell?.indexForCell.row)!]
        }
    }
 

}

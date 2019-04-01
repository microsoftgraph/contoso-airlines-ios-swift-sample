//
//  FlightDetailViewController.swift
//  FlightSchedule
//
//  Copyright (c) Microsoft. All rights reserved.
//  Licensed under the MIT license. See LICENSE.txt in the project root for license information.
//

import UIKit
import MSGraphClientModels

class FlightDetailViewController: UIViewController {
    @IBOutlet weak var flightNameLabel: UILabel!
    @IBOutlet weak var flightDescriptionLabel: UILabel!
    @IBOutlet weak var departureGateLabel: UILabel!
    @IBOutlet weak var departureTimeLabel: UILabel!
    
    var crewListVC: CrewListTableViewController?
    
    var flight: MSGraphEvent?
    
    var flightName: String? {
        didSet {
            flightNameLabel.text = flightName
        }
    }
    
    var flightDescription: String? {
        didSet {
            flightDescriptionLabel.text = flightDescription
        }
    }
    
    var departureGate: String? {
        didSet {
            departureGateLabel.text = "Departs from gate \(departureGate ?? "TBD")"
        }
    }
    
    var departureTime: Date? {
        didSet {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            departureTimeLabel.text = formatter.string(from: departureTime!)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        flightName = flight?.subject
        flightDescription = flight?.location?.displayName
        departureTime = Date(from: (flight?.start)!)
        
        let flightData = FlightDataEventExtension(extensions: flight!.extensions)
        departureGate = flightData?.departureGate
        
        crewListVC?.crewIds = flightData?.crewMembers
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let crewListVC as CrewListTableViewController:
            self.crewListVC = crewListVC
        default:
            break;
        }
    }
}

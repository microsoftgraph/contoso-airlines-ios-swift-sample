//
//  FlightDetailViewController.swift
//  FlightSchedule
//
//  Created by Jason Johnston on 3/26/19.
//  Copyright © 2019 Jason Johnston. All rights reserved.
//

import UIKit

class FlightDetailViewController: UIViewController {
    @IBOutlet weak var flightNameLabel: UILabel!
    @IBOutlet weak var flightDescriptionLabel: UILabel!
    @IBOutlet weak var departureGateLabel: UILabel!
    @IBOutlet weak var departureTimeLabel: UILabel!
    
    var flightId: String?
    
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

        print("Showing detail for \(String(describing: flightId))")
        // TODO: Get event by ID and populate the fields
        flightName = "Flight 875"
        flightDescription = "JAX to JFK"
        departureGate = "C9"
        departureTime = Date(timeIntervalSinceNow: 0)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

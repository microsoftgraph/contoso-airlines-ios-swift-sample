//
//  MainViewController.swift
//  FlightSchedule
//
//  Copyright (c) Microsoft. All rights reserved.
//  Licensed under the MIT license. See LICENSE.txt in the project root for license information.
//

import UIKit
import MSGraphClientModels

class MainViewController: UIViewController {
    
    @IBOutlet weak var profilePictureView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var nextFlightNumber: UILabel!
    @IBOutlet weak var nextFlightName: UILabel!
    @IBOutlet weak var nextFlightDeparture: UILabel!
    @IBAction func unwindFromDetailView(unwindSegue: UIStoryboardSegue) {}
    
    var spinner: SpinnerViewController?
    var crewPhotosVC: CrewPhotosViewController?
    var flightScheduleVC: FlightScheduleViewController?
    
    var nextFlight: MSGraphEvent?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        spinner = SpinnerViewController()
        addChild(spinner!)
        spinner!.view.frame = view.frame
        view.addSubview(spinner!.view)
        spinner!.didMove(toParent: self)
        
        // Get the logged-in user
        GraphManager.instance.getMe {
            (user: MSGraphUser?, error: Error?) in
            guard let me = user, error == nil else {
                print("Error getting user: \(error!)")
                self.updateUserInfo(name: "", profilePhoto: nil)
                return
            }
            
            // Get the user's photo
            ProfilePhotoUtil.instance.getUserPhoto(userId: me.entityId, completion: {
                (image: UIImage?, photoError: Error?) in
                guard let userPhoto = image, photoError == nil else {
                    print("Error getting photo: \(photoError!)")
                    self.updateUserInfo(name: me.displayName!, profilePhoto: nil)
                    return
                } 
                self.updateUserInfo(name: me.displayName!, profilePhoto: userPhoto)
                
                // Get the users calendar for the next 30 days
                let start = Calendar.current.startOfDay(for: Date())
                let end = Calendar.current.date(byAdding: .day, value: 30, to: start)
                
                GraphManager.instance.getCalendarView(start: start, end: end!, completion: {
                    (events: [MSGraphEvent]?, error: Error?) in
                    guard let flights = events, error == nil else {
                        return
                    }
                    
                    self.updateFlights(flights: flights)
                })
            })
        }
        
        profilePictureView.image = UIImage(named: "default-photo")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let crewPhotosVC as CrewPhotosViewController:
            self.crewPhotosVC = crewPhotosVC
        case let flightScheduleVC as FlightScheduleViewController:
            self.flightScheduleVC = flightScheduleVC
        case let flightDetailVC as FlightDetailViewController:
            flightDetailVC.flight = self.nextFlight
        default:
            break;
        }
    }
    
    @IBAction func signOut() {
        print("Sign out")
        AuthenticationManager.instance.signOutAccounts()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.showSignInView()
    }
    
    private func updateUserInfo(name: String, profilePhoto: UIImage?) {
        DispatchQueue.main.async {
            self.userLabel.text = name
            if (profilePhoto != nil) {
                self.profilePictureView.image = profilePhoto
            }
            
            self.spinner!.willMove(toParent: nil)
            self.spinner!.view.removeFromSuperview()
            self.spinner!.removeFromParent()
        }
    }
    
    private func updateFlights(flights: [MSGraphEvent]) {
        DispatchQueue.main.async {
            if (flights.count > 0) {
                let nextFlight = flights.first
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .short
                
                print("Event subject: \(String(describing: nextFlight?.subject))")
                print("Event start: \(String(describing: nextFlight?.start?.dateTime))")
                
                self.nextFlightNumber.text = nextFlight?.subject
                self.nextFlightName.text = nextFlight?.location?.displayName
                
                let startDate = Date(from: (nextFlight?.start)!)
                let departure = dateFormatter.string(from: startDate)
                self.nextFlightDeparture.text = "Departs: \(departure)"
                self.nextFlight = nextFlight
                
                let flightData = FlightDataEventExtension(extensions: nextFlight!.extensions)
                
                ProfilePhotoUtil.instance.getUsersPhotos(userIds: (flightData?.crewMembers)!, completion: {
                    (crewPhotos: [UIImage?], error: Error?) in
                    guard error == nil else {
                        print("Error getting crew photos: \(String(describing: error))")
                        return
                    }
                    
                    self.crewPhotosVC?.setPhotos(photos: crewPhotos)
                })
                
                var remainingFlights = flights
                remainingFlights.removeFirst()
                self.flightScheduleVC?.setFlights(flights: remainingFlights)
 
            }
        }
    }
    
    private func showSpinner() {
        
    }
    
    private func hideSpinner() {
        
    }
    
    @IBAction func handleTap(recognizer: UITapGestureRecognizer) {
        print("Load detail for \(String(describing: nextFlight))")
    }
}

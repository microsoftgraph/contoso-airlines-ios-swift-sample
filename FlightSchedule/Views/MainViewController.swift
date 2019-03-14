//
//  MainViewController.swift
//  FlightSchedule
//
//  Copyright (c) Microsoft. All rights reserved.
//  Licensed under the MIT license. See LICENSE.txt in the project root for license information.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var profilePictureView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var nextFlightNumber: UILabel!
    @IBOutlet weak var nextFlightName: UILabel!
    @IBOutlet weak var nextFlightDeparture: UILabel!
    
    var spinner: SpinnerViewController?
    var crewPhotosVC: CrewPhotosViewController?
    var flightScheduleVC: FlightScheduleViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        spinner = SpinnerViewController()
        addChild(spinner!)
        spinner!.view.frame = view.frame
        view.addSubview(spinner!.view)
        spinner!.didMove(toParent: self)
        
        let userIds = [ "49f60b80-4448-4b22-b499-a1c757a0d9e6", "b4ccd4ac-a66d-4a35-ad41-7258bace4c0f", "668acae2-d14d-4d14-b338-af7ba855e09a" ]
        
        ProfilePhotoUtil.instance.getUsersPhotos(userIds: userIds) {
            (images: [UIImage?]?, error: Error?) in
            guard let userImages = images, error == nil else {
                return
            }
            
            self.crewPhotosVC?.setPhotos(photos: userImages)
        }
        
        // Get the logged-in user
        GraphManager.instance.getMe {
            (user: GraphUser?, error: Error?) in
            guard let me = user, error == nil else {
                print("Error getting user: \(error!)")
                self.updateUserInfo(name: "", profilePhoto: nil)
                return
            }
            
            // Get the user's photo
            ProfilePhotoUtil.instance.getUserPhoto(userId: me.id!, completion: {
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
                    (events: [GraphEvent]?, error: Error?) in
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
    
    private func updateFlights(flights: [GraphEvent]) {
        DispatchQueue.main.async {
            if (flights.count > 0) {
                let nextFlight = flights.first
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .short
                
                self.nextFlightNumber.text = nextFlight?.subject
                self.nextFlightName.text = nextFlight?.location
                let departure = dateFormatter.string(from: (nextFlight?.start)!)
                self.nextFlightDeparture.text = "Departs: \(departure)"
                
                var remainingFlights = flights
                remainingFlights.removeFirst()
                self.flightScheduleVC?.setFlights(flights: remainingFlights)
            }
        }
    }
}

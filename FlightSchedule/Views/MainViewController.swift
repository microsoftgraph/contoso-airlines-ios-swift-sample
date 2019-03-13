//
//  MainViewController.swift
//  FlightSchedule
//
//  Created by Jason Johnston on 3/6/19.
//  Copyright © 2019 Jason Johnston. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var profilePictureView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    
    var spinner: SpinnerViewController?
    var crewPhotosVC: CrewPhotosViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        spinner = SpinnerViewController()
        addChild(spinner!)
        spinner!.view.frame = view.frame
        view.addSubview(spinner!.view)
        spinner!.didMove(toParent: self)
        
        let userIds = [ "49f60b80-4448-4b22-b499-a1c757a0d9e6", "b4ccd4ac-a66d-4a35-ad41-7258bace4c0f", "668acae2-d14d-4d14-b338-af7ba855e09a" ]
        GraphManager.instance.getUserPhotosBatch(userIds: userIds) {
            (images: [UIImage?]?, error: Error?) in
            guard let userImages = images, error == nil else {
                return
            }
            
            self.crewPhotosVC?.setPhotos(photos: userImages)
        }
        
        GraphManager.instance.getMe {
            (user: GraphUser?, error: Error?) in
            guard let me = user, error == nil else {
                print("Error getting user: \(error!)")
                self.updateUserInfo(name: "", profilePhoto: nil)
                return
            }
            
            GraphManager.instance.getUserPhoto(userId: me.id!, completion: {
                (image: UIImage?, photoError: Error?) in
                guard let userPhoto = image, photoError == nil else {
                    print("Error getting photo: \(photoError!)")
                    self.updateUserInfo(name: me.displayName!, profilePhoto: nil)
                    return
                } 
                self.updateUserInfo(name: me.displayName!, profilePhoto: userPhoto)
            })
        }
        
        profilePictureView.image = UIImage(named: "default-photo")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let crewPhotosVC as CrewPhotosViewController:
            self.crewPhotosVC = crewPhotosVC
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
}

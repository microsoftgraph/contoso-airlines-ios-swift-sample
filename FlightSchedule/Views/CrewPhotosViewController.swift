//
//  CrewPhotosViewController.swift
//  FlightSchedule
//
//  Copyright (c) Microsoft. All rights reserved.
//  Licensed under the MIT license. See LICENSE.txt in the project root for license information.
//

import UIKit

class CrewPhotosViewController: UICollectionViewController {
    
    private let crewPhotoReuseId = "CrewPhotoCell"
    var crewPhotos: [UIImage?]?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func setPhotos(photos: [UIImage?]) {
        crewPhotos = photos
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = crewPhotos?.count else {
            return 0
        }
        return count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: crewPhotoReuseId, for: indexPath) as! CrewPhotoCollectionViewCell
    
        // Configure the cell
        let crewPhoto = crewPhotos?[indexPath.row]
        if crewPhoto == nil {
            cell.crewImageView.image = UIImage(named: "default-photo")
        } else {
            cell.crewImageView.image = crewPhoto
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let cellCount = crewPhotos?.count ?? 0
        let totalCellWidth = 40 * cellCount
        let totalSpacingWidth = cellCount == 0 ? 0 : 10 * (cellCount - 1)
        
        let leftInset = (collectionView.layer.frame.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
}

extension CrewPhotosViewController : UICollectionViewDelegateFlowLayout {}

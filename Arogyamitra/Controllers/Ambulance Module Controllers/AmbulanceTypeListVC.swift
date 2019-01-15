//
//  AmbulanceTypeListVC.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 15/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

import UIKit

class AmbulanceTypeListVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var ambulanceTypeListCollectionView: UICollectionView!
    
    //Static Variables To be changes later
    let usersCurrentLatitude = "3243.546"
    let usersCurrentLongitude = "45.878"
    let patientId = 157
    
    //Storage Variables
    var ambulaceTypeListArray = [AmbulanceTypeListResult]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getAmbulanceTypeList()
        ambulanceTypeListCollectionView.delegate = self
        ambulanceTypeListCollectionView.dataSource = self
    }

}


//MARK: Collection View Implementation
extension AmbulanceTypeListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ambulaceTypeListArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = ambulanceTypeListCollectionView.dequeueReusableCell(withReuseIdentifier: "AmbulanceTypeListCollCell", for: indexPath) as? AmbulanceTypeListCollCell else {return UICollectionViewCell()}
        cell.configureAmbulanceListCollCell(ambulanceTypeListData: ambulaceTypeListArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        var totalCellWidth = Int()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
           totalCellWidth = 400 * ambulaceTypeListArray.count
        }else {
            totalCellWidth = 200 * ambulaceTypeListArray.count
        }
        
        let totalSpacingWidth = 10 * (ambulaceTypeListArray.count - 1)

        let leftInset = self.view.frame.width - CGFloat(totalCellWidth + totalSpacingWidth) / 2
        let rightInset = leftInset

        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 170, height: 170)
//    }
    
}

//MARK: API CALL To Get Ambulance Type List
extension AmbulanceTypeListVC {
    
    func getAmbulanceTypeList() {
        
        self.view.makeToastActivity(.center)
        AmbulanceServices.instance.getAmbulanceTypeList(withUserLatitude: usersCurrentLatitude, withUserLongitude: usersCurrentLongitude, andPatientId: patientId) { (success, returnedAmbulaceListResponse) in
            
            if let returnedAmbulaceListResponse = returnedAmbulaceListResponse {
                self.ambulaceTypeListArray = returnedAmbulaceListResponse.results
            }
            
            DispatchQueue.main.async {
                self.ambulanceTypeListCollectionView.reloadData()
                self.view.hideToastActivity()
            }
            
            //print("Ambulance Type Array: \(self.ambulaceTypeListArray)")
        }
        
    }
    
}

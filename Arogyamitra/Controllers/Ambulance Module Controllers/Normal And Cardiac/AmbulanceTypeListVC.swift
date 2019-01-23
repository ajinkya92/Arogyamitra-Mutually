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
    let usersCurrentLatitude = "19.0659"
    let usersCurrentLongitude = "73.0011"
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
        cell.tag = indexPath.row
        cell.delegate = self
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
    
}

//MARK: AmbulanceType CollectionView Cell Delegate Implementation
extension AmbulanceTypeListVC: AmbulanceTypeListCollCellDelegate {
    
    func didTapAmbulanceSelectionBtn(_ tag: Int) {
        
        if ambulaceTypeListArray[tag].ambulanceTypeID != 23 {
            guard let exceptEmergencyAmbulanceVc = storyboard?.instantiateViewController(withIdentifier: "ExceptEmergencyAmbulanceVC") as? ExceptEmergencyAmbulanceVC else {return}
            exceptEmergencyAmbulanceVc.ambulanceTypeId = ambulaceTypeListArray[tag].ambulanceTypeID
            exceptEmergencyAmbulanceVc.title = ambulaceTypeListArray[tag].name
            exceptEmergencyAmbulanceVc.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            self.navigationController?.pushViewController(exceptEmergencyAmbulanceVc, animated: true)
        }else {
            //Here is the code for emergency ambulance booking start process.
            let bookingConfirmationAlert = UIAlertController(title: "Book Ambulance", message: "Do you really want to book emergency ambulance?", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "YES", style: .default) { (action) in
                //perform Ok Action here...
                guard let emergenyAmbulanceBookingVc = self.storyboard?.instantiateViewController(withIdentifier: "EmergencyAmbulanceRequestVC") as? EmergencyAmbulanceRequestVC else {return}
                self.navigationController?.pushViewController(emergenyAmbulanceBookingVc, animated: true)
                
            }
            let cancelAction = UIAlertAction(title: "NO", style: .cancel) { (action) in
                //Dismiss Alert Here
                print("Dismiss Action Performed Here...")
                self.dismiss(animated: true, completion: nil)
            }
            bookingConfirmationAlert.addAction(okAction)
            bookingConfirmationAlert.addAction(cancelAction)
            
            self.present(bookingConfirmationAlert, animated: true, completion: nil)
        }
        
        
        
    }
    
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

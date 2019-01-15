//
//  ExceptEmergencyAmbulanceVC.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 15/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

import UIKit

class ExceptEmergencyAmbulanceVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var ambulanceListTableView: UITableView!
    
    let usersCurrentLatitude = "19.0659"
    let usersCurrentLongitude = "73.0011"
    let patientId = 157
    var ambulanceTypeId: Int!
    
    //Storage Variables
    var ambulanceExceptEmergencyArray = [AmbulanceExceptEmergencyResult]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getAmbulanceListExceptEmergency()
        
    }

}

//MARK: API CALL TO GET AMBULANCE LIST EXCEPT EMERGENCY
extension ExceptEmergencyAmbulanceVC {
    
    func getAmbulanceListExceptEmergency() {
        
        self.view.makeToastActivity(.center)
        AmbulanceServices.instance.getAmbulanceListExceptExergency(withAmbulanceTypeId: ambulanceTypeId, userCurrentLatitude: usersCurrentLatitude, userCurrentLongitude: usersCurrentLongitude, patientId: patientId) { (success, returnedAmbulanceResponse) in
            
            if let returnedAmbulanceResponse = returnedAmbulanceResponse {
                self.ambulanceExceptEmergencyArray = returnedAmbulanceResponse.results
            }
            
            DispatchQueue.main.async {
                self.view.hideToastActivity()
            }
            
            print("Ambulance List Except Emergency Ambulance: \(self.ambulanceExceptEmergencyArray)")
        }
    }
    
}

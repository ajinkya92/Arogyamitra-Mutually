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
        ambulanceListTableView.delegate = self
        ambulanceListTableView.dataSource = self
        
    }

}

//MARK: AmbulanceList Tableview Implementation.
extension ExceptEmergencyAmbulanceVC: UITableViewDelegate,  UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ambulanceExceptEmergencyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = ambulanceListTableView.dequeueReusableCell(withIdentifier: "ExceptEmergencyAmbulanceTblCell") as? ExceptEmergencyAmbulanceTblCell else {return UITableViewCell()}
        cell.configureExceptEmergencyAmbulanceTblCell(exceptEmergencyData: ambulanceExceptEmergencyArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
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
                self.ambulanceListTableView.reloadData()
                self.view.hideToastActivity()
            }
            
            //print("Ambulance List Except Emergency Ambulance: \(self.ambulanceExceptEmergencyArray)")
        }
    }
    
}

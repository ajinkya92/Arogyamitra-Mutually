//
//  GymnasiumDetailsVC.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 03/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

import UIKit
import Kingfisher

class GymnasiumDetailsVC: UIViewController {
    
    
    //Outlets
    @IBOutlet weak var mainDisplayImageView: UIImageView!
    @IBOutlet weak var gymnasiumNameLbl: UILabel!
    @IBOutlet weak var gymnasiumAddressLbl: UILabel!
    //Map outlet Required here
    @IBOutlet weak var mobileNumberLbl: UILabel!
    @IBOutlet weak var availableDaysLbl: UILabel!
    @IBOutlet weak var availableTimingsLbl: UILabel!
    //Plans Dropdown to be done with pod
    @IBOutlet weak var discountPercentageLbl: UILabel!
    @IBOutlet weak var seeServicesTblView: UITableView!
    @IBOutlet weak var seeReviewsTblView: UITableView!
    
    
    
    //MARK: Required values from previous Gymnasium VC
    var patientId = 157
    var gymnasiumId: Int!
    
    //Strorage Variables
    var gymnasiumDetailsArray = [GymnasiumDetailsServiceResult]()
    var gymnasiumTimingsArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getGymnasiumDetails()
        
    }

}

// MARK: API CALL TO GET GYM DETAILS
extension GymnasiumDetailsVC {
    
    func getGymnasiumDetails() {
        
        guard let gymnasiumId = gymnasiumId else {return}
        
        GymnasiumServices.instance.getGymnasiumDetails(withGymnasiumId: gymnasiumId, andPatientId: patientId) { (success, returnedGymnasiumDetails) in
            
            if let returnedGymnasiumDetails = returnedGymnasiumDetails {
                self.gymnasiumDetailsArray = returnedGymnasiumDetails.results
            }
            
            //print(self.gymnasiumDetailsArray)
            DispatchQueue.main.async {
                self.assignValuesToOutlets()
            }
            
        }
    }
    
}

//MARK: EXTRA Function that assigns values to Outlets
extension GymnasiumDetailsVC {
    
    func assignValuesToOutlets() {
        
        for allValues in self.gymnasiumDetailsArray {
            guard let mainDisplayimageUrl = URL(string: allValues.photo) else {return}
            self.mainDisplayImageView.kf.setImage(with: mainDisplayimageUrl)
            self.gymnasiumNameLbl.text = allValues.name
            self.gymnasiumAddressLbl.text = allValues.address
            self.mobileNumberLbl.text = allValues.mobileno
            self.availableDaysLbl.text = avaliableDays(days: allValues.daysAvailability)
            for timings in allValues.gymnasiumYogaTimings {
                gymnasiumTimingsArray.append("\(timings.openTime) - \(timings.closeTime)")
            }
            self.availableTimingsLbl.text = gymnasiumTimingsArray.joined(separator: ",")
            self.discountPercentageLbl.text = "\(allValues.discount)"
            
        }
        
    }
 
    
}

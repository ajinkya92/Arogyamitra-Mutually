//
//  ExceptEmergencyAmbulanceTblCell.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 15/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

import UIKit

class ExceptEmergencyAmbulanceTblCell: UITableViewCell {
    
    @IBOutlet weak var ambulanceTypeLbl: UILabel!
    @IBOutlet weak var mobileNumberBtn: UIButton!
    @IBOutlet weak var feesLbl: UILabel!
    @IBOutlet weak var bookingLbl: UILabel!
    @IBOutlet weak var availableLbl: UILabel!
    @IBOutlet weak var outOfServiceImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureExceptEmergencyAmbulanceTblCell(exceptEmergencyData: AmbulanceExceptEmergencyResult) {
        
        self.ambulanceTypeLbl.text = exceptEmergencyData.ambulanceName
        self.mobileNumberBtn.setTitle(exceptEmergencyData.mobileno, for: .normal)
        self.feesLbl.text = "Rs. \(exceptEmergencyData.chargesPerKM )/- per km"
        self.bookingLbl.text = "Rs. \(exceptEmergencyData.bookingAmount )/-"
        //self.availableLbl.text = exceptEmergencyData.ambulanceIsAvailable
        
        //Out of Service Logic
        
        if exceptEmergencyData.outOfStationService != 0 {
            self.outOfServiceImage.image = UIImage(named: "checked")
        }else {
            self.outOfServiceImage.image = UIImage(named: "cancelRed")
        }
        
    }

}

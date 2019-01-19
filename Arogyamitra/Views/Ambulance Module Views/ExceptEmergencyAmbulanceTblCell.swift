//
//  ExceptEmergencyAmbulanceTblCell.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 15/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

import UIKit
import Kingfisher

protocol ExceptEmergencyAmbulanceTblCellDelegate {
    func didTapMobileNumberAt(_ tag: Int)
}

class ExceptEmergencyAmbulanceTblCell: UITableViewCell {
    
    @IBOutlet weak var ambulanceImage: UIImageView!
    @IBOutlet weak var ambulanceNameLbl: UILabel!
    @IBOutlet weak var mobileNumberBtn: UIButton!
    @IBOutlet weak var feesLbl: UILabel!
    @IBOutlet weak var bookingLbl: UILabel!
    @IBOutlet weak var availableLbl: UILabel!
    @IBOutlet weak var outOfServiceImage: UIImageView!
    
    var delegate: ExceptEmergencyAmbulanceTblCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureExceptEmergencyAmbulanceTblCell(exceptEmergencyData: AmbulanceExceptEmergencyResult) {
        
        guard let ambulanceImage = URL(string: exceptEmergencyData.ambulancePhoto) else {return}
        self.ambulanceImage.kf.setImage(with: ambulanceImage)
        self.ambulanceNameLbl.text = exceptEmergencyData.ambulanceName
        self.mobileNumberBtn.setTitle(exceptEmergencyData.mobileno, for: .normal)
        self.feesLbl.text = "Rs. \(exceptEmergencyData.chargesPerKM )/- per km"
        self.bookingLbl.text = "Rs. \(exceptEmergencyData.bookingAmount )/-"
        self.availableLbl.text = exceptEmergencyData.ambulanceIsAvailable
        
        //Out of Service Logic
        
        if exceptEmergencyData.outOfStationService != 0 {
            self.outOfServiceImage.image = UIImage(named: "checked")
        }else {
            self.outOfServiceImage.image = UIImage(named: "cancelRed")
        }
        
        // Ambulance Available Logic
        
        if exceptEmergencyData.ambulanceIsAvailable == "" {
            self.availableLbl.text = "Available"
        }else if exceptEmergencyData.ambulanceIsAvailable == "booked" {
            self.availableLbl.text = "Request Pending"
        }else {
            self.availableLbl.text = "Accepted"
        }
        
    }
    
    
    //Action For Buttons
    @IBAction func mobileNumberBtnTapped(_ sender: UIButton) {
        delegate?.didTapMobileNumberAt(self.tag)
    }

}

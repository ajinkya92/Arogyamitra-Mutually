//
//  DoctorListTableViewCell.swift
//  Arogyamitra
//
//  Created by Nitin Landge on 09/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import UIKit
import Kingfisher

class DoctorListTableViewCell: UITableViewCell {

    @IBOutlet weak var label_speciality: UILabel!
    @IBOutlet weak var label_drName: UILabel!
    @IBOutlet weak var label_degree: UILabel!
    @IBOutlet weak var label_address: UILabel!
    @IBOutlet weak var label_fees: UILabel!
    @IBOutlet weak var label_avaliable: UILabel!
    @IBOutlet weak var label_exp: UILabel!
    @IBOutlet weak var label_1: UILabel!
    @IBOutlet weak var label_2: UILabel!
    @IBOutlet weak var imageView_drImage: CustomCircularImage!
    @IBOutlet weak var btn_drTotalServices: UIButton!

    @IBOutlet weak var btn_like: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDrList(data :DoctorResultList)
    {
        imageView_drImage.kf.indicatorType = .activity
        imageView_drImage.kf.setImage(with: URL(string:data.photo!
            .replacingOccurrences(of: " ", with: "%20")), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        
        label_speciality.text = data.doctor_speciality
        label_drName.text = data.doctor_name
        label_degree.text = data.degree?[0].degree_name
        label_address.text = data.address
//        label_fees.text = String(data.fees)
        label_avaliable.text = data.days_availability
        label_exp.text = data.experience
        label_1.text = data.hospital_services?[0].services
        label_2.text = data.hospital_services?[1].services
        
        if (data.hospital_services?.count)! > 2
        {
            let count = (data.hospital_services?.count)
            btn_drTotalServices.setTitle(String("+" + String(count! - 2) + " More"), for: .normal)
        }
        
        if data.favourite == true {
            btn_like.setImage(#imageLiteral(resourceName: "like_select"), for: .normal)
        }else{
            btn_like.setImage(#imageLiteral(resourceName: "like_deSelect"), for: .normal)
        }
    }
}


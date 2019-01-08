//
//  DoctorTableViewCell.swift
//  Arogyamitra
//
//  Created by Nitin Landge on 09/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import UIKit
import Kingfisher

class DoctorTableViewCell: UITableViewCell {

    @IBOutlet weak var imageView_image: CustomCircularImage!
    @IBOutlet weak var label_name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setDoctorData(data : DoctorResultArray)
    {
        label_name.text = data.name
        imageView_image.kf.indicatorType = .activity
        imageView_image.kf.setImage(with: URL(string:data.photo!
            .replacingOccurrences(of: " ", with: "%20")), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
    }
    
    
    func setDoctorData(data : Speciality_list)
    {
        label_name.text = data.name
        imageView_image.kf.indicatorType = .activity
        imageView_image.kf.setImage(with: URL(string:data.photo!
            .replacingOccurrences(of: " ", with: "%20")), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
    }
}

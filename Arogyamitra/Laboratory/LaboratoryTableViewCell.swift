//
//  LaboratoryTableViewCell.swift
//  Arogyamitra
//
//  Created by Sangram Powar on 27/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import UIKit

class LaboratoryTableViewCell: UITableViewCell {

    @IBOutlet weak var imageView_labImage: CustomCircularImage!
    @IBOutlet weak var label_labName: UILabel!
    @IBOutlet weak var label_labAddress: UILabel!
    @IBOutlet weak var label_homePickUp: UILabel!
    @IBOutlet weak var label_timeAvalible: UILabel!
    @IBOutlet weak var label_daysAvaliable: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLabdata(data: LaboratoryResult)
    {
        label_labName.text = data.name
        label_labAddress.text = data.address
//        label_homePickUp.text = data.home_pickup
        label_timeAvalible.text = (data.opentime!) + "-" + (data.closetime!)
        label_daysAvaliable.text = avaliableDays(days: data.days_availability!)
        
        imageView_labImage.kf.setImage(with: URL(string:(data.photo!
            .replacingOccurrences(of: " ", with: "%20"))), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
    }

}

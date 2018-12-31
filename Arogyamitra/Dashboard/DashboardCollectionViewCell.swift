//
//  DashboardCollectionViewCell.swift
//  Arogyamitra
//
//  Created by Nitin Landge on 07/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import UIKit
import Kingfisher

class DashboardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label_name: UILabel!
    @IBOutlet weak var imageView_image: UIImageView!
    
    
    
    func setDashboardData(data : DashboardResultArray)
    {
        label_name.text = data.module_name
        imageView_image.kf.indicatorType = .activity
        imageView_image.kf.setImage(with: URL(string:data.photo!
            .replacingOccurrences(of: " ", with: "%20")), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
    }

}

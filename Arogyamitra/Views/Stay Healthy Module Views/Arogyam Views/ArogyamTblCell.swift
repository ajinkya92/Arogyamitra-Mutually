//
//  ArogyamTblCell.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 09/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

import UIKit
import Kingfisher

class ArogyamTblCell: UITableViewCell {
    
    @IBOutlet weak var outerRoundView: UIView!
    @IBOutlet weak var displayImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        outerRoundView.layer.cornerRadius = 5
        
    }

    func configureArogyamTblCell(arogyamResult: ArogyamNotificationResult) {
        guard let displayImageUrl = URL(string: arogyamResult.photo) else {return}
        displayImage.kf.setImage(with: displayImageUrl)
        titleLbl.text = arogyamResult.title
        descriptionLbl.text = arogyamResult.description
    }

}

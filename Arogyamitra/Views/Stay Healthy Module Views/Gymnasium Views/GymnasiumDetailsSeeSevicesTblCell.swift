//
//  GymnasiumDetailsSeeSevicesTblCell.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 05/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

import UIKit

class GymnasiumDetailsSeeSevicesTblCell: UITableViewCell {
    
    @IBOutlet weak var gymnasiumServiceNameLbl: UILabel!
    @IBOutlet weak var dotImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureGymnasiumDetailsSeeServicesTblCell(gymnasiumServicesList: GymnasiumDetailsServiceGymnasiumYogaService) {
        
        self.dotImageView.image = UIImage(named: "dotimage")
        self.gymnasiumServiceNameLbl.text = gymnasiumServicesList.services
    }

}

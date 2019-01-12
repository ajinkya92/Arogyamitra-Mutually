//
//  YogaCentreDetailsSeeServicesTblCell.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 07/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

import UIKit

class YogaCentreDetailsSeeServicesTblCell: UITableViewCell {
    
    @IBOutlet weak var yogaCentreDetailsServiceNameLbl: UILabel!
    @IBOutlet weak var yogaCentreDetailsdotImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureGymnasiumDetailsSeeServicesTblCell(yogaCentreDetailsServicesList: GymnasiumDetailsServiceGymnasiumYogaService) {
        
        self.yogaCentreDetailsdotImageView.image = UIImage(named: "dotimage")
        self.yogaCentreDetailsServiceNameLbl.text = yogaCentreDetailsServicesList.services
    }

}

//
//  YogaCentreServicePopupCollectionCell.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 07/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

import UIKit

class YogaCentreServicePopupCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var yogaCentreserviceNameLbl: UILabel!
    
    func configureServicesCell(yogaCentreServices: GymnasiumYogaService) {
        self.yogaCentreserviceNameLbl.text = yogaCentreServices.services
    }
    
}

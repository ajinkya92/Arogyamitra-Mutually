//
//  GymnasiumServicePopupCollectionCell.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 02/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

import UIKit

class GymnasiumServicePopupCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var serviceNameLbl: UILabel!
    
    func configureServicesCell(gymnasiumServices: GymnasiumYogaService) {
        self.serviceNameLbl.text = gymnasiumServices.services
    }
    
}

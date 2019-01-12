//
//  YogaCentreSearchTblCell.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 07/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

import UIKit

class YogaCentreSearchTblCell: UITableViewCell {
    
    @IBOutlet weak var yogaCentreNameLbl: UILabel!
    @IBOutlet weak var yogaCentreCategoryLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    func configureYogaCentreSearchCell(yogaCentreListResult: GymnasiumOrYogaListResult) {
        self.yogaCentreNameLbl.text = yogaCentreListResult.name
        self.yogaCentreCategoryLbl.text = yogaCentreListResult.typeName
    }

}

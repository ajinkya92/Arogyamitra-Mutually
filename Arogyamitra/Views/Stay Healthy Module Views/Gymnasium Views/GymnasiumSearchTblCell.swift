//
//  GymnasiumSearchTblCell.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 03/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

import UIKit

class GymnasiumSearchTblCell: UITableViewCell {
    
    @IBOutlet weak var gymnasiumNameLbl: UILabel!
    @IBOutlet weak var gymnasiumCategoryLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureGymnasiumSearchCell(gymnasiumListResult: GymnasiumOrYogaListResult) {
        self.gymnasiumNameLbl.text = gymnasiumListResult.name
        self.gymnasiumCategoryLbl.text = gymnasiumListResult.typeName
    }

}

//
//  MenuDrawerTableViewCell.swift
//  CFL FI
//
//  Created by Nitin Landge on 01/04/76.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import UIKit

class MenuDrawerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView_Menu: UIImageView!
    @IBOutlet weak var lbl_MenuName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

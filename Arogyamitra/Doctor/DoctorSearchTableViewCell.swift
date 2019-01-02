//
//  DoctorSearchTableViewCell.swift
//  Arogyamitra
//
//  Created by Nitin Landge on 17/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import UIKit

class DoctorSearchTableViewCell: UITableViewCell {

    @IBOutlet private weak var categoryName: UILabel!
    @IBOutlet private weak var categoryType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}

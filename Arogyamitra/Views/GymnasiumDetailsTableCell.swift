//
//  GymnasiumDetailsTableCell.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 31/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import UIKit
import Kingfisher

class GymnasiumDetailsTableCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var gymnasiumImage: UIImageView!
    @IBOutlet weak var gymnasiumNameLbl: UILabel!
    @IBOutlet weak var gymnasiumAddressLbl: UILabel!
    @IBOutlet weak var availableDaysLbl: UILabel!
    @IBOutlet weak var gymnasiumTimeLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configureGymnasiumCell(gymnasiumListResult: GymnasiumListResult) {
        
        guard let imageUrl = URL(string: gymnasiumListResult.photo) else {return}
        
        self.gymnasiumImage.kf.setImage(with: imageUrl)
        self.gymnasiumNameLbl.text = gymnasiumListResult.name
        self.gymnasiumAddressLbl.text = gymnasiumListResult.address
        self.availableDaysLbl.text = gymnasiumListResult.daysAvailability
        
        
        //Continue with Timings Display
        
    }

}

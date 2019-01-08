//
//  SearchTrainerTblCell.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 08/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

import UIKit

class SearchTrainerTblCell: UITableViewCell {
    
    @IBOutlet weak var trainerNameLbl: UILabel!
    @IBOutlet weak var trainerType: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureSearchTrainerCell(trainerDetails: TrainerListResult) {
        self.trainerNameLbl.text = trainerDetails.name
        self.trainerType.text = "trainer"
    }

}

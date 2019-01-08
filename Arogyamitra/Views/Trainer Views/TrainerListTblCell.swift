//
//  TrainerListTblCell.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 08/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

import UIKit
import Kingfisher

protocol TrainerListTblCellDelegate {
    func didtapVisitButton(tag: Int)
}

class TrainerListTblCell: UITableViewCell {
    
    @IBOutlet weak var trainerProfileImage: UIImageView!
    @IBOutlet weak var trainerNameLbl: UILabel!
    @IBOutlet weak var trainerAddressLbl: UILabel!
    @IBOutlet weak var experienceYearsLbl: UILabel!
    @IBOutlet weak var trainerStarRating: CosmosView!
    
    var delegate: TrainerListTblCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureTrainerListCell(trainerListData: TrainerListResult) {
        
        guard let trainerProfileImageUrl = URL(string: trainerListData.photo) else {return}
        trainerProfileImage.kf.setImage(with: trainerProfileImageUrl)
        trainerNameLbl.text = trainerListData.name
        trainerAddressLbl.text = trainerListData.address
        experienceYearsLbl.text = trainerListData.experience
        trainerStarRating.rating = Double(trainerListData.averageRating)
    }
    
    //Visit Button Action
    
    @IBAction func visitButtonTapped(_ sender: UIButton) {
        print("Trainer Visit Button Tapped")
        delegate?.didtapVisitButton(tag: self.tag)
    }

}

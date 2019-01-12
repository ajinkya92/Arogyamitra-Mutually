//
//  TrainerDetailsReviewTblCell.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 09/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

import UIKit

class TrainerDetailsReviewTblCell: UITableViewCell {
    
    @IBOutlet weak var trainerReviewerNameLbl: UILabel!
    @IBOutlet weak var trainerReviewTextLbl: UILabel!
    @IBOutlet weak var trainerRatings: CosmosView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureTrainerDetailsReviewCell(reviewListData:TrainerDetailsReviewsList) {
        trainerReviewerNameLbl.text = reviewListData.reviewBy
        trainerReviewTextLbl.text = reviewListData.review
        trainerRatings.rating = Double(reviewListData.rating)
    }

}

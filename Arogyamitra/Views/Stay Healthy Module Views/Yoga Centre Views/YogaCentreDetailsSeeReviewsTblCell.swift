//
//  YogaCentreDetailsSeeReviewsTblCell.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 07/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

import UIKit

class YogaCentreDetailsSeeReviewsTblCell: UITableViewCell {
    
    @IBOutlet weak var yogaCentreDetailsReviewerName: UILabel!
    @IBOutlet weak var yogaCentreDetailsReviewText: UILabel!
    @IBOutlet weak var yogaCentreDetailsCosmosStarRatings: CosmosView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configureGymnasiumDetailsSeeReviewsCell(yogaCentreDetailsReviewsList: GymnasiumDetailsServiceReviewsList) {
        
        self.yogaCentreDetailsReviewerName.text = yogaCentreDetailsReviewsList.reviewBy
        self.yogaCentreDetailsReviewText.text = yogaCentreDetailsReviewsList.review
        yogaCentreDetailsCosmosStarRatings.rating = Double(yogaCentreDetailsReviewsList.rating)
    }
    
}

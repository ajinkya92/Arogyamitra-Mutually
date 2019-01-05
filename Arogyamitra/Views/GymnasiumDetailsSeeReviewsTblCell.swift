//
//  GymnasiumDetailsSeeReviewsTblCell.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 05/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

import UIKit

class GymnasiumDetailsSeeReviewsTblCell: UITableViewCell {
    
    @IBOutlet weak var reviewerName: UILabel!
    @IBOutlet weak var reviewText: UILabel!
    @IBOutlet weak var cosmosStarRatings: CosmosView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureGymnasiumDetailsSeeReviewsCell(reviewsList: GymnasiumDetailsServiceReviewsList) {
        
        self.reviewerName.text = reviewsList.reviewBy
        self.reviewText.text = reviewsList.review
        cosmosStarRatings.rating = Double(reviewsList.rating)
    }

}

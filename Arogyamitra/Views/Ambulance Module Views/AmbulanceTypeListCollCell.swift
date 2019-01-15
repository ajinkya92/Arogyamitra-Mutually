//
//  AmbulanceTypeListCollCell.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 15/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

import UIKit
import Kingfisher

protocol AmbulanceTypeListCollCellDelegate {
    func didTapAmbulanceSelectionBtn(_ tag: Int)
}

class AmbulanceTypeListCollCell: UICollectionViewCell {
    
    @IBOutlet weak var ambulanceTypeImage: UIImageView!
    @IBOutlet weak var ambulanceTypeNameLbl: UILabel!
    @IBOutlet weak var ambulanceAvailableCount: UILabel!
    
    var delegate:AmbulanceTypeListCollCellDelegate?
    
    
    func configureAmbulanceListCollCell(ambulanceTypeListData: AmbulanceTypeListResult) {
        guard let ambulanceTypeImageUrl = URL(string: ambulanceTypeListData.photo) else {return}
        self.ambulanceTypeImage.kf.setImage(with: ambulanceTypeImageUrl)
        self.ambulanceTypeNameLbl.text = ambulanceTypeListData.name
        self.ambulanceAvailableCount.text = "\(ambulanceTypeListData.ambulanceCount) Available"
    }
    
    //Actions
    @IBAction func ambulanceSelectionBtnTapped(_ sender: UIButton) {
        //print("Ambulance Selection button Tapped")
        delegate?.didTapAmbulanceSelectionBtn(self.tag)
    }
    
}

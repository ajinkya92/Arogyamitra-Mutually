//
//  YogaListTblCell.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 07/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

import UIKit
import Kingfisher

protocol YogaListTblCelllDelegate {
    
    func didTapServiceLabel(_ tag: Int)
    func didTapVisitButton(_ tag: Int)
    
}

class YogaListTblCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var yogaCentreImage: UIImageView!
    @IBOutlet weak var yogaCentreNameLbl: UILabel!
    @IBOutlet weak var yogaCentreAddressLbl: UILabel!
    @IBOutlet weak var yogaCentreAvailableDaysLbl: UILabel!
    @IBOutlet weak var yogaCentreTimeLbl: UILabel!
    @IBOutlet weak var yogaCentrecosmosStarRatings: CosmosView!
    
    //Services Stackview and Outlets
    
    @IBOutlet weak var yogaCentreservicesStackView: UIStackView!
    @IBOutlet weak var yogaCentreserviceLbl1: UILabel!
    @IBOutlet weak var yogaCentreserviceLbl2: UILabel!
    @IBOutlet weak var yogaCentreshowMoreLbl: UILabel!
    
    //Storage Variables
    var yogaCentretimingStringArray = [String]()
    var yogaCentreservicesStringArray = [String]()
    
    var delegate: YogaListTblCelllDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        settingTapGestureInstance()
        
    }
    
    func configureYogaCentreCell(yogaCentreListResult: GymnasiumOrYogaListResult) {
        
        guard let imageUrl = URL(string: yogaCentreListResult.photo) else {return}
        
        self.yogaCentreImage.kf.setImage(with: imageUrl)
        self.yogaCentreNameLbl.text = yogaCentreListResult.name
        self.yogaCentreAddressLbl.text = yogaCentreListResult.address
        self.yogaCentrecosmosStarRatings.rating = Double(yogaCentreListResult.averageRating)
        let convertedDaysString = avaliableDays(days: yogaCentreListResult.daysAvailability)
        self.yogaCentreAvailableDaysLbl.text = convertedDaysString
        
        for timings in yogaCentreListResult.gymnasiumYogaTimings {
            yogaCentretimingStringArray.append("\(timings.openTime) - \(timings.closeTime)")
        }
        self.yogaCentreTimeLbl.text = yogaCentretimingStringArray.joined(separator: ",")
        
        
        for services in yogaCentreListResult.gymnasiumYogaServices {
            yogaCentreservicesStringArray.append(services.services)
        }
        self.yogaCentreshowMoreLbl.text = "+\(yogaCentreservicesStringArray.count - 2) More"
        
        displayingServicesResult()
    }
    
    func displayingServicesResult() {
        
        if yogaCentreservicesStringArray.count < 0 {
            yogaCentreservicesStackView.isHidden = true
        }else if yogaCentreservicesStringArray.count == 1 {
            yogaCentreserviceLbl1.text = yogaCentreservicesStringArray[0]
            yogaCentreserviceLbl2.backgroundColor = UIColor.clear
            yogaCentreserviceLbl2.text = ""
            yogaCentreshowMoreLbl.backgroundColor = UIColor.clear
            yogaCentreshowMoreLbl.text = ""
        }else if yogaCentreservicesStringArray.count == 2 {
            yogaCentreserviceLbl1.text = yogaCentreservicesStringArray[0]
            yogaCentreserviceLbl2.text = yogaCentreservicesStringArray[1]
            yogaCentreshowMoreLbl.isHidden = true
        }else {
            yogaCentreserviceLbl1.text = yogaCentreservicesStringArray[0]
            yogaCentreserviceLbl2.text = yogaCentreservicesStringArray[1]
            yogaCentreshowMoreLbl.isHidden = false
        }
        
    }
    
}

extension YogaListTblCell {
    
    //MARK: Assigning Tap Gesture to all Label
    
    func setTapGesture() -> UITapGestureRecognizer {
        var tapRecognizer = UITapGestureRecognizer()
        tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.serviceLabelTapped(sender:)))
        return tapRecognizer
        
        
    }
    
    func settingTapGestureInstance() {
        yogaCentreserviceLbl1.addGestureRecognizer(setTapGesture())
        yogaCentreserviceLbl2.addGestureRecognizer(setTapGesture())
        yogaCentreshowMoreLbl.addGestureRecognizer(setTapGesture())
        yogaCentreserviceLbl1.isUserInteractionEnabled = true
        yogaCentreserviceLbl2.isUserInteractionEnabled = true
        yogaCentreshowMoreLbl.isUserInteractionEnabled = true
    }
    
    //MARK: Services Label Tap Function
    
    @objc func serviceLabelTapped(sender: UITapGestureRecognizer) {
        delegate?.didTapServiceLabel(self.tag)
        //print("Service Label Tap Working inside YogaCentreTblCell")
        
    }
    
    //MARK: Visit Button Action
    
    @IBAction func visitButtonTapped(_ sender: UIButton) {
        delegate?.didTapVisitButton(self.tag)
        //print("Visit Button Tap Working inside YogaCentreTblCell")
    }
    
}

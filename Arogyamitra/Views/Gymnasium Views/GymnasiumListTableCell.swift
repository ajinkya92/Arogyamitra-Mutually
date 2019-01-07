//
//  GymnasiumDetailsTableCell.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 31/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import UIKit
import Kingfisher

protocol GymnasiumListTableCellDelegate {
    func didTapServiceLabel(_ tag: Int)
    func didTapVisitButton(_ tag: Int)

}

class GymnasiumListTableCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var gymnasiumImage: UIImageView!
    @IBOutlet weak var gymnasiumNameLbl: UILabel!
    @IBOutlet weak var gymnasiumAddressLbl: UILabel!
    @IBOutlet weak var availableDaysLbl: UILabel!
    @IBOutlet weak var gymnasiumTimeLbl: UILabel!
    @IBOutlet weak var cosmosStarRatings: CosmosView!
    
    
    //Services Stackview and Outlets
    
    @IBOutlet weak var servicesStackView: UIStackView!
    @IBOutlet weak var serviceLbl1: UILabel!
    @IBOutlet weak var serviceLbl2: UILabel!
    @IBOutlet weak var showMoreLbl: UILabel!
    
    var delegate: GymnasiumListTableCellDelegate?
    
    //Storage Variables
    var timingStringArray = [String]()
    var servicesStringArray = [String]()

    override func awakeFromNib() {
        super.awakeFromNib()
        settingTapGestureInstance()
        
        
    }

    func configureGymnasiumCell(gymnasiumListResult: GymnasiumListResult) {
        
        guard let imageUrl = URL(string: gymnasiumListResult.photo) else {return}
        
        self.gymnasiumImage.kf.setImage(with: imageUrl)
        self.gymnasiumNameLbl.text = gymnasiumListResult.name
        self.gymnasiumAddressLbl.text = gymnasiumListResult.address
        self.cosmosStarRatings.rating = Double(gymnasiumListResult.averageRating)
        let convertedDaysString = avaliableDays(days: gymnasiumListResult.daysAvailability)
        self.availableDaysLbl.text = convertedDaysString
        
        for timings in gymnasiumListResult.gymnasiumYogaTimings {
            timingStringArray.append("\(timings.openTime) - \(timings.closeTime)")
        }
        self.gymnasiumTimeLbl.text = timingStringArray.joined(separator: ",")
        
        
        for services in gymnasiumListResult.gymnasiumYogaServices {
            servicesStringArray.append(services.services)
        }
        self.showMoreLbl.text = "+\(servicesStringArray.count - 2) More"
        
        displayingServicesResult()
    }
    
    func displayingServicesResult() {
        
        if servicesStringArray.count < 0 {
            servicesStackView.isHidden = true
        }else if servicesStringArray.count == 1 {
            serviceLbl1.text = servicesStringArray[0]
            serviceLbl2.backgroundColor = UIColor.clear
            serviceLbl2.text = ""
            showMoreLbl.backgroundColor = UIColor.clear
            showMoreLbl.text = ""
        }else if servicesStringArray.count == 2 {
            serviceLbl1.text = servicesStringArray[0]
            serviceLbl2.text = servicesStringArray[1]
            showMoreLbl.isHidden = true
        }else {
            serviceLbl1.text = servicesStringArray[0]
            serviceLbl2.text = servicesStringArray[1]
            showMoreLbl.isHidden = false
        }
        
    }

}

extension GymnasiumListTableCell {
    
    //MARK: Assigning Tap Gesture to all Label
    
    func setTapGesture() -> UITapGestureRecognizer {
        var tapRecognizer = UITapGestureRecognizer()
        tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.serviceLabelTapped(sender:)))
        return tapRecognizer
        
        
    }
    
    func settingTapGestureInstance() {
        serviceLbl1.addGestureRecognizer(setTapGesture())
        serviceLbl2.addGestureRecognizer(setTapGesture())
        showMoreLbl.addGestureRecognizer(setTapGesture())
        serviceLbl1.isUserInteractionEnabled = true
        serviceLbl2.isUserInteractionEnabled = true
        showMoreLbl.isUserInteractionEnabled = true
    }
    
    //MARK: Services Label Tap Function
    
    @objc func serviceLabelTapped(sender: UITapGestureRecognizer) {
        delegate?.didTapServiceLabel(self.tag)
        //print("Service Label Tap Working")
        
    }
    
    //MARK: Visit Button Action
    
    @IBAction func visitButtonTapped(_ sender: UIButton) {
        delegate?.didTapVisitButton(self.tag)
        //print("Visit Button Tap Working")
    }
    
}

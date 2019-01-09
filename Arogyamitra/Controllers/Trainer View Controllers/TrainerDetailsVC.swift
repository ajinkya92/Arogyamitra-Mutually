//
//  TrainerDetailsVC.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 08/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

import UIKit
import Kingfisher

class TrainerDetailsVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var trainerDisplayImageView: UIImageView!
    @IBOutlet weak var trainerNameLbl: UILabel!
    @IBOutlet weak var trainerAddressLbl: UILabel!
    @IBOutlet weak var trainerMainMobileNumberLbl: UILabel!
    @IBOutlet weak var trainerAdditionalMobileNumberStackView: UIStackView!
    @IBOutlet weak var trainerOptional1MobileNumberLbl: UILabel!
    @IBOutlet weak var trainerOptional2MobileNumberLbl: UILabel!
    @IBOutlet weak var trainerChargesLbl: UILabel!
    @IBOutlet weak var trainerExperienceLbl: UILabel!
    @IBOutlet weak var seeReviewsBtn: UIButton!
    @IBOutlet weak var SeeReviewsTableView: UITableView!
    
    //Automationa Contraints
    
    @IBOutlet weak var seeReviewTableViewHeightConstraint: NSLayoutConstraint!
    
    //MARK: Required Variable from previous view Controllers
    var trainerId: Int!
    var patientId = 157
    
    //MARK: Storage Collection Variables
    var trainerDetailsArray = [TrainerDetailsResult]()
    var trainerReviewListArray = [TrainerDetailsReviewsList]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getTrainerDetails()
        SeeReviewsTableView.delegate = self
        SeeReviewsTableView.dataSource = self
    }

}

//MARK: SEE Reviews Tableview Implementation

extension TrainerDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trainerReviewListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = SeeReviewsTableView.dequeueReusableCell(withIdentifier: "TrainerDetailsReviewTblCell") as? TrainerDetailsReviewTblCell else {return UITableViewCell()}
        cell.configureTrainerDetailsReviewCell(reviewListData: trainerReviewListArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}

// MARK: API CALL To GET Trainer Details
extension TrainerDetailsVC {
    
    func getTrainerDetails() {
        self.view.makeToastActivity(.center)
        guard let trainerId = self.trainerId else {return}
        TrainerServices.instance.getTrainerDetails(withTrainerId: trainerId, andPatientId: patientId) { (success, returenedTrainerDetails) in
            
            if let returenedTrainerDetails = returenedTrainerDetails {
                self.trainerDetailsArray = returenedTrainerDetails.results
            }
            
            DispatchQueue.main.async {
                self.assignValuesToOutlets()
                self.SeeReviewsTableView.reloadData()
                self.view.hideToastActivity()
            }
            
        }
        
    }
    
    func assignValuesToOutlets() {
        
        for allValues in self.trainerDetailsArray {
            
            guard let trainerImageUrl = URL(string: allValues.photo) else {return}
            self.trainerDisplayImageView.kf.setImage(with: trainerImageUrl)
            self.trainerNameLbl.text = allValues.name
            self.trainerAddressLbl.text = allValues.address
            self.trainerMainMobileNumberLbl.text = allValues.mobileno
            //Logic for multiple mobile number...
            let additionalMobileNumberArray = allValues.mobilenoMultiple.components(separatedBy: ",")
            
            
            if additionalMobileNumberArray.count != 1 {
                if additionalMobileNumberArray[0] != "" {
                    self.trainerOptional1MobileNumberLbl.text = additionalMobileNumberArray[0]
                }else {self.trainerOptional1MobileNumberLbl.isHidden = true}

                if additionalMobileNumberArray[1] != "" {
                    self.trainerOptional2MobileNumberLbl.text = additionalMobileNumberArray[1]
                }else {self.trainerOptional2MobileNumberLbl.isHidden = true}
            }else {trainerAdditionalMobileNumberStackView.isHidden = true}
            
            
            self.trainerChargesLbl.text = allValues.chargesPerVisit
            self.trainerExperienceLbl.text = allValues.experience
            self.seeReviewsBtn.setTitle("See Reviews \(allValues.totalReviews)", for: .normal)
            
            if allValues.totalReviews == 0 {
                self.SeeReviewsTableView.isHidden = true
                self.seeReviewTableViewHeightConstraint.constant = 0
                self.SeeReviewsTableView.reloadData()
            }else {
                self.seeReviewTableViewHeightConstraint.constant = 250
                self.SeeReviewsTableView.reloadData()
            }
            
            self.trainerReviewListArray = allValues.reviewsList
            
        }
        
    }
    
}

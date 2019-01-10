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
    @IBOutlet weak var trainerOptional1MobileNumberBtn: UIButton!
    @IBOutlet weak var trainerOptional2MobileNumberBtn: UIButton!
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
    
    //Variables
    var mobilePhoneNumberString = String()
    var trainerOptional1MobileString = String()
    var trainerOptional2MobileString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTrainerDetails()
        SeeReviewsTableView.delegate = self
        SeeReviewsTableView.dataSource = self
        addTapGestureToView()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        SeeReviewsTableView.layer.removeAllAnimations()
        seeReviewTableViewHeightConstraint.constant = SeeReviewsTableView.contentSize.height
        UIView.animate(withDuration: 0.5) {
            self.SeeReviewsTableView.updateConstraints()
            self.SeeReviewsTableView.layoutIfNeeded()
        }
    }
    
    //MARK: ACTIONS PERFORMED HERE
    
    @IBAction func seeReviewsBtnTapped(_ sender: UIButton) {
        //print("See Review Btn Tapped")
        self.SeeReviewsTableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        SeeReviewsTableView.reloadData()
    }
    
    @IBAction func trainerOptional1MobileNumberBtn(_ sender: UIButton) {
        
        if let url = URL(string: "tel://\(trainerOptional1MobileString)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    @IBAction func trainerOptional2MobileNumberBtn(_ sender: UIButton) {
        
        if let url = URL(string: "tel://\(trainerOptional2MobileString)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        
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
            self.mobilePhoneNumberString = allValues.mobileno
            //Logic for multiple mobile number...
            let additionalMobileNumberArray = allValues.mobilenoMultiple.components(separatedBy: ",")
            
            
            if additionalMobileNumberArray.count != 1 {
                if additionalMobileNumberArray[0] != "" {
                    self.trainerOptional1MobileNumberBtn.setTitle("\(additionalMobileNumberArray[0])", for: .normal)
                    self.trainerOptional1MobileString = additionalMobileNumberArray[0]
                }else {self.trainerOptional1MobileNumberBtn.isHidden = true}
                
                if additionalMobileNumberArray[1] != "" {
                    self.trainerOptional2MobileNumberBtn.setTitle("\(additionalMobileNumberArray[1])", for: .normal)
                    self.trainerOptional2MobileString = additionalMobileNumberArray[1]
                }else {self.trainerOptional2MobileNumberBtn.isHidden = true}
            }else {trainerAdditionalMobileNumberStackView.isHidden = true}
            
            
            self.trainerChargesLbl.text = allValues.chargesPerVisit
            self.trainerExperienceLbl.text = allValues.experience
            self.seeReviewsBtn.setTitle("See Reviews \(allValues.totalReviews)", for: .normal)
            self.trainerReviewListArray = allValues.reviewsList
            self.seeReviewTableViewHeightConstraint.constant = 0
            
        }
        
    }
    
    
}

// MARK: Function To Add Tap Gesture To Call Labels
extension TrainerDetailsVC {
    
    func setGesture() -> UITapGestureRecognizer {
        
        var myRegognizer = UITapGestureRecognizer()
        myRegognizer = UITapGestureRecognizer(target: self, action: #selector(self.addTapGestureToView))
        return myRegognizer
    }
    
    @objc func addTapGestureToView() {
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(mobileLabelTappedForCall))
        trainerMainMobileNumberLbl.isUserInteractionEnabled = true
        trainerMainMobileNumberLbl.addGestureRecognizer(tap1)
        
    }
    
    @objc func mobileLabelTappedForCall() {
        
        if let url = URL(string: "tel://\(mobilePhoneNumberString)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }

    }
    
}

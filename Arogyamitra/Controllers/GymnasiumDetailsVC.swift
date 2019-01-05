//
//  GymnasiumDetailsVC.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 03/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

import UIKit
import Kingfisher

class GymnasiumDetailsVC: UIViewController {
    
    
    //Outlets
    @IBOutlet weak var mainDisplayImageView: UIImageView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var gymnasiumNameLbl: UILabel!
    @IBOutlet weak var gymnasiumAddressLbl: UILabel!
    //Map outlet Required here
    @IBOutlet weak var mobileNumberLbl: UILabel!
    @IBOutlet weak var availableDaysLbl: UILabel!
    @IBOutlet weak var availableTimingsLbl: UILabel!
    @IBOutlet weak var discountPercentageLbl: UILabel!
    @IBOutlet weak var seeServicesTblView: UITableView!
    @IBOutlet weak var seeReviewsTblView: UITableView!
    @IBOutlet weak var selectPlanPickerView: UIPickerView!
    @IBOutlet weak var seeServicesBtn: UIButton!
    @IBOutlet weak var seeReviewsBtn: UIButton!
    
    //Outlets That Hides
    @IBOutlet weak var imageCollectionStackView: UIStackView!
    
    //ACTIONS Done Here...
    
    @IBAction func seeServicesBtnTapped(_ sender: UIButton) {
        seeServicesTblView.isHidden = false
        seeServicesTblView.reloadData()
    }
    
    @IBAction func seeReviewsBtnTapped(_ sender: UIButton) {
        seeReviewsTblView.isHidden = false
        seeReviewsTblView.reloadData()
    }
    
    //MARK: Required values from previous Gymnasium VC
    var patientId = 157
    var gymnasiumId: Int!
    
    //Variables
    var selectedPlanValue = String()
    
    //Strorage Variables
    var gymnasiumDetailsArray = [GymnasiumDetailsServiceResult]()
    var gymnasiumImageGalleryArray = [GymnasiumDetailsServiceGymnasiumYogaGallery]()
    var gymnasiumServicesArray = [GymnasiumDetailsServiceGymnasiumYogaService]()
    var gymnasiumPlansArray = [GymnasiumDetailsServiceGymnasiumYogaPlan]()
    var gymnasiumReviewListArray = [GymnasiumDetailsServiceReviewsList]()
    var gymnasiumTimingsArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getGymnasiumDetails()
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        selectPlanPickerView.delegate = self
        selectPlanPickerView.dataSource = self
        seeServicesTblView.delegate = self
        seeServicesTblView.dataSource = self
        seeServicesTblView.isHidden = true
        seeReviewsTblView.delegate = self
        seeReviewsTblView.dataSource = self
        seeReviewsTblView.isHidden = true
        
    }

}

//MARK: CollectionView for Additional 4 Images
extension GymnasiumDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gymnasiumImageGalleryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "GymnasiumPhotoGalleryCollectionCell", for: indexPath) as? GymnasiumPhotoGalleryCollectionCell else {return UICollectionViewCell()}
        cell.configureGymnasiumImageGalleryCell(gymnasiumPhotoGalleryImages: gymnasiumImageGalleryArray[indexPath.row])
        return cell
    }
    
}

//MARK: GYMNASIUM SERVICES TABLE VIEW
extension GymnasiumDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == seeServicesTblView {
            return gymnasiumServicesArray.count
        }else {
            return gymnasiumReviewListArray.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == seeServicesTblView {
            guard let cell = seeServicesTblView.dequeueReusableCell(withIdentifier: "GymnasiumDetailsSeeSevicesTblCell") as? GymnasiumDetailsSeeSevicesTblCell else {return UITableViewCell()}
            cell.configureGymnasiumDetailsSeeServicesTblCell(gymnasiumServicesList: gymnasiumServicesArray[indexPath.row])
            return cell
        }else {
            guard let cell = seeReviewsTblView.dequeueReusableCell(withIdentifier: "GymnasiumDetailsSeeReviewsTblCell") as? GymnasiumDetailsSeeReviewsTblCell else {return UITableViewCell()}
            cell.configureGymnasiumDetailsSeeReviewsCell(reviewsList: self.gymnasiumReviewListArray[indexPath.row])
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
}



//MARK: SELECT PLAN PICKER VIEW IMPLEMENTATION
extension GymnasiumDetailsVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return gymnasiumPlansArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let returnedPlanString = "\(gymnasiumPlansArray[row].planName) \(gymnasiumPlansArray[row].amount) Rs"
        return returnedPlanString
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPlanValue = "\(gymnasiumPlansArray[row].planName) \(gymnasiumPlansArray[row].amount) Rs"
        //print(selectedPlanValue)
    }
    
    
}


// MARK: API CALL TO GET GYM DETAILS
extension GymnasiumDetailsVC {
    
    func getGymnasiumDetails() {
        
        guard let gymnasiumId = gymnasiumId else {return}
        
        GymnasiumServices.instance.getGymnasiumDetails(withGymnasiumId: gymnasiumId, andPatientId: patientId) { (success, returnedGymnasiumDetails) in
            
            if let returnedGymnasiumDetails = returnedGymnasiumDetails {
                self.gymnasiumDetailsArray = returnedGymnasiumDetails.results
            }
            
            //print(self.gymnasiumDetailsArray)
            DispatchQueue.main.async {
                self.assignValuesToOutlets()
                if self.gymnasiumImageGalleryArray.isEmpty {
                    self.imageCollectionStackView.isHidden = true
                }
                self.imageCollectionView.reloadData()
                self.selectPlanPickerView.reloadAllComponents()
                self.seeServicesTblView.reloadData()
                self.seeReviewsTblView.reloadData()
            }
            
        }
    }
    
}

//MARK: EXTRA Function that assigns values to Outlets
extension GymnasiumDetailsVC {
    
    func assignValuesToOutlets() {
        
        for allValues in self.gymnasiumDetailsArray {
            guard let mainDisplayimageUrl = URL(string: allValues.photo) else {return}
            self.mainDisplayImageView.kf.setImage(with: mainDisplayimageUrl)
            self.gymnasiumNameLbl.text = allValues.name
            self.gymnasiumAddressLbl.text = allValues.address
            self.mobileNumberLbl.text = allValues.mobileno
            self.availableDaysLbl.text = avaliableDays(days: allValues.daysAvailability)
            for timings in allValues.gymnasiumYogaTimings {
                gymnasiumTimingsArray.append("\(timings.openTime) - \(timings.closeTime)")
            }
            self.availableTimingsLbl.text = gymnasiumTimingsArray.joined(separator: ",")
            self.discountPercentageLbl.text = "\(allValues.discount)"
            self.gymnasiumImageGalleryArray = allValues.gymnasiumYogaGallery
            self.gymnasiumPlansArray = allValues.gymnasiumYogaPlans
            self.gymnasiumServicesArray = allValues.gymnasiumYogaServices
            self.seeServicesBtn.setTitle("See Services: (\((self.gymnasiumServicesArray.count)))", for: .normal)
            self.gymnasiumReviewListArray = allValues.reviewsList
            self.seeReviewsBtn.setTitle("See Reviews: \(allValues.totalReviews)", for: .normal)
            
            //Condition to hide reviews table in no reviews
            if allValues.totalReviews == 0 {
                self.seeReviewsBtn.isEnabled = false
            }
            
            //Condition to hide Services in no services present
            if self.gymnasiumServicesArray.isEmpty {
                self.seeServicesBtn.isEnabled = false
            }
            
        }
        
    }
 
    
}

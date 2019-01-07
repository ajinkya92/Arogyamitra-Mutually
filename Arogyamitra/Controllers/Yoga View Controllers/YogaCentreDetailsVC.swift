//
//  YogaCentreDetailsVC.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 07/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

import UIKit
import MapKit

class YogaCentreDetailsVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var yogaCentreDetailsmainDisplayImageView: UIImageView!
    @IBOutlet weak var yogaCentreDetailsimageCollectionView: UICollectionView!
    @IBOutlet weak var yogaCentreDetailsgymnasiumNameLbl: UILabel!
    @IBOutlet weak var yogaCentreDetailsgymnasiumAddressLbl: UILabel!
    @IBOutlet weak var yogaCentreDetailsmobileNumberLbl: UILabel!
    @IBOutlet weak var yogaCentreDetailsavailableDaysLbl: UILabel!
    @IBOutlet weak var yogaCentreDetailsavailableTimingsLbl: UILabel!
    @IBOutlet weak var yogaCentreDetailsdiscountPercentageLbl: UILabel!
    @IBOutlet weak var yogaCentreDetailsseeServicesTblView: UITableView!
    @IBOutlet weak var yogaCentreDetailsseeReviewsTblView: UITableView!
    @IBOutlet weak var yogaCentreDetailsselectPlanPickerView: UIPickerView!
    @IBOutlet weak var yogaCentreDetailsseeServicesBtn: UIButton!
    @IBOutlet weak var yogaCentreDetailsseeReviewsBtn: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var yogaCentreDetailsbookButton: UIButton!
    
    //Outlets That Hides
    @IBOutlet weak var yogaCentreDetailsImageCollectionStackView: UIStackView!
    
    //ACTIONS Done Here...
    
    @IBAction func seeServicesBtnTapped(_ sender: UIButton) {
        yogaCentreDetailsseeServicesTblView.isHidden = false
        yogaCentreDetailsseeServicesTblView.reloadData()
    }
    
    @IBAction func seeReviewsBtnTapped(_ sender: UIButton) {
        yogaCentreDetailsseeReviewsTblView.isHidden = false
        yogaCentreDetailsseeReviewsTblView.reloadData()
    }
    
    @IBAction func yogaCentreDetailsBookBtnTapped(_ sender: UIButton) {
        print("Book Button Tapped")
        //Here perform action for Bookings, navigate to calendar and then final page - @Nitin's Implementation
    }
    
    @IBAction func yogaCentreDetailsWriteReviewBtnTapped(_ sender: UIButton) {
        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        guard let reviewAndRatingsVc = mainStoryboard.instantiateViewController(withIdentifier: "RatingAndReviewViewController") as? RatingAndReviewViewController else {return}
        reviewAndRatingsVc.bgImagePassedFromOtherVC = self.gymnasiumImageUrlToPassReviewAndRatingsVc
        self.navigationController?.pushViewController(reviewAndRatingsVc, animated: true)
        
    }
    
    //MARK: Required values from & for previous and next View Controller Gymnasium VC
    var patientId = 157
    var yogaCentreId: Int!
    var notAvailableDatesString = String()
    var gymnasiumImageUrlToPassReviewAndRatingsVc = String()
    
    //Variables
    var selectedPlanValue = String()
    let annotation = MKPointAnnotation()
    var latitudeString = String()
    var longitudeString = String()
    var mobilePhoneNumberString = String()
    
    //Strorage Variables
    var yogaCentreDetailsArray = [GymnasiumOrYogaDetailsServiceResult]()
    var yogaCentreDetailsImageGalleryArray = [GymnasiumDetailsServiceGymnasiumYogaGallery]()
    var yogaCentreDetailsServicesArray = [GymnasiumDetailsServiceGymnasiumYogaService]()
    var yogaCentreDetailsPlansArray = [GymnasiumDetailsServiceGymnasiumYogaPlan]()
    var yogaCentreDetailsReviewListArray = [GymnasiumDetailsServiceReviewsList]()
    var yogaCentreDetailsTimingsArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getYogaCentreDetails()
        yogaCentreDetailsimageCollectionView.delegate = self
        yogaCentreDetailsimageCollectionView.dataSource = self
        yogaCentreDetailsselectPlanPickerView.delegate = self
        yogaCentreDetailsselectPlanPickerView.dataSource = self
        yogaCentreDetailsseeServicesTblView.delegate = self
        yogaCentreDetailsseeServicesTblView.dataSource = self
        yogaCentreDetailsseeServicesTblView.isHidden = true
        yogaCentreDetailsseeReviewsTblView.delegate = self
        yogaCentreDetailsseeReviewsTblView.dataSource = self
        yogaCentreDetailsseeReviewsTblView.isHidden = true
        
        //Adding Tap Gesture to mobile number label
        let tapToCallGesture = UITapGestureRecognizer(target: self, action: #selector(self.yogaCentreDetailsmobileNumberTapToCall(_:)))
        yogaCentreDetailsmobileNumberLbl.isUserInteractionEnabled = true
        yogaCentreDetailsmobileNumberLbl.addGestureRecognizer(tapToCallGesture)
        
    }

}


//MARK: CollectionView for Additional 4 Images
extension YogaCentreDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return yogaCentreDetailsImageGalleryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = yogaCentreDetailsimageCollectionView.dequeueReusableCell(withReuseIdentifier: "YogaCentrePhotoGalleryCollectionCell", for: indexPath) as? YogaCentrePhotoGalleryCollectionCell else {return UICollectionViewCell()}
        
        cell.configureYogaCentreImageGalleryCell(yogaCentrePhotoGalleryImages: yogaCentreDetailsImageGalleryArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let imageUrlAtIndex = URL(string: "\(yogaCentreDetailsImageGalleryArray[indexPath.row].photo)") else {return}
        yogaCentreDetailsmainDisplayImageView.kf.setImage(with: imageUrlAtIndex)
    }
    
}

//MARK: Yoga Centre Details SERVICES TABLE VIEW
extension YogaCentreDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == yogaCentreDetailsseeServicesTblView {
            return yogaCentreDetailsServicesArray.count
        }else {
            return yogaCentreDetailsReviewListArray.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == yogaCentreDetailsseeServicesTblView {
            guard let cell = yogaCentreDetailsseeServicesTblView.dequeueReusableCell(withIdentifier: "YogaCentreDetailsSeeServicesTblCell") as? YogaCentreDetailsSeeServicesTblCell else {return UITableViewCell()}
            cell.configureGymnasiumDetailsSeeServicesTblCell(yogaCentreDetailsServicesList: yogaCentreDetailsServicesArray[indexPath.row])
            return cell
        }else {
            guard let cell = yogaCentreDetailsseeReviewsTblView.dequeueReusableCell(withIdentifier: "YogaCentreDetailsSeeReviewsTblCell") as? YogaCentreDetailsSeeReviewsTblCell else {return UITableViewCell()}
            cell.configureGymnasiumDetailsSeeReviewsCell(yogaCentreDetailsReviewsList: self.yogaCentreDetailsReviewListArray[indexPath.row])
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
extension YogaCentreDetailsVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return yogaCentreDetailsPlansArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let returnedPlanString = "\(yogaCentreDetailsPlansArray[row].planName) \(yogaCentreDetailsPlansArray[row].amount) Rs"
        return returnedPlanString
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPlanValue = "\(yogaCentreDetailsPlansArray[row].planName) \(yogaCentreDetailsPlansArray[row].amount) Rs"
        //print(selectedPlanValue)
    }
    
    
}

//MARK: MAP METHODS IMPLEMENTATION
extension YogaCentreDetailsVC {
    
    func setMapAnnotationDetails()  {
        
        let latitude = (latitudeString as NSString).doubleValue
        let longitude = (longitudeString as NSString).doubleValue
        
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        mapView.addAnnotation(annotation)
        
        let latDelta:CLLocationDegrees = 0.05
        
        let lonDelta:CLLocationDegrees = 0.05
        
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapView.setRegion(region, animated: false)
        
    }
    
    
    @IBAction func btn_plusPressed(_ sender: Any) {
        let region = MKCoordinateRegion(center: self.mapView.region.center, span: MKCoordinateSpan(latitudeDelta: mapView.region.span.latitudeDelta*0.7, longitudeDelta: mapView.region.span.longitudeDelta*0.7))
        mapView.setRegion(region, animated: true)
    }
    
    @IBAction func btn_minusPressed(_ sender: Any) {
        let zoom = getZoom()
        if zoom > 3.5{
            let region = MKCoordinateRegion(center: self.mapView.region.center, span: MKCoordinateSpan(latitudeDelta: mapView.region.span.latitudeDelta/0.7, longitudeDelta: mapView.region.span.longitudeDelta/0.7))
            mapView.setRegion(region, animated: true)
        }
    }
    
    func getZoom() -> Double {
        var angleCamera = self.mapView.camera.heading
        if angleCamera > 270 {
            angleCamera = 360 - angleCamera
        } else if angleCamera > 90 {
            angleCamera = fabs(angleCamera - 180)
        }
        let angleRad = Double.pi * angleCamera / 180
        let width = Double(self.view.frame.size.width)
        let height = Double(self.view.frame.size.height)
        let heightOffset : Double = 20
        let spanStraight = width * self.mapView.region.span.longitudeDelta / (width * cos(angleRad) + (height - heightOffset) * sin(angleRad))
        return log2(360 * ((width / 256) / spanStraight)) + 1
    }
    
}



//MARK: MOBILE NUMBER TAP TO CALL IMPLEMENTATION
extension YogaCentreDetailsVC {
    
    @objc func yogaCentreDetailsmobileNumberTapToCall(_ sender: UITapGestureRecognizer) {
        if let url = URL(string: "tel://\(mobilePhoneNumberString)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}

// MARK: API CALL TO GET GYM DETAILS
extension YogaCentreDetailsVC {
    
    func getYogaCentreDetails() {
        
        self.view.makeToastActivity(.center)
        guard let yogaCentreId = yogaCentreId else {return}
        
        
        GymnasiumServices.instance.getGymnasiumOrYogaDetails(withGymnasiumOrYogaId: yogaCentreId, andPatientId: patientId) { (success, returnedGymnasiumDetails) in
            
            if let returnedGymnasiumDetails = returnedGymnasiumDetails {
                self.yogaCentreDetailsArray = returnedGymnasiumDetails.results
            }
            
            //print("Yoga Centre Details Array: \(self.yogaCentreDetailsArray)")
            
            DispatchQueue.main.async {
                self.assignValuesToOutlets()
                if self.yogaCentreDetailsImageGalleryArray.isEmpty {
                    self.yogaCentreDetailsImageCollectionStackView.isHidden = true
                }
                self.yogaCentreDetailsimageCollectionView.reloadData()
                self.yogaCentreDetailsselectPlanPickerView.reloadAllComponents()
                self.yogaCentreDetailsseeServicesTblView.reloadData()
                self.yogaCentreDetailsseeReviewsTblView.reloadData()
                //self.setMapAnnotationDetails()
                self.view.hideToastActivity()
            }
            
        }
    }
    
}

//MARK: EXTRA Function that assigns values to Outlets
extension YogaCentreDetailsVC {
    
    func assignValuesToOutlets() {
        
        for allValues in self.yogaCentreDetailsArray {
            guard let mainDisplayimageUrl = URL(string: allValues.photo) else {return}
            self.yogaCentreDetailsmainDisplayImageView.kf.setImage(with: mainDisplayimageUrl)
            self.gymnasiumImageUrlToPassReviewAndRatingsVc = allValues.photo
            self.yogaCentreDetailsgymnasiumNameLbl.text = allValues.name
            self.yogaCentreDetailsgymnasiumAddressLbl.text = allValues.address
            self.yogaCentreDetailsmobileNumberLbl.text = allValues.mobileno
            self.mobilePhoneNumberString = allValues.mobileno
            self.yogaCentreDetailsavailableDaysLbl.text = avaliableDays(days: allValues.daysAvailability)
            for timings in allValues.gymnasiumYogaTimings {
                yogaCentreDetailsTimingsArray.append("\(timings.openTime) - \(timings.closeTime)")
            }
            self.yogaCentreDetailsavailableTimingsLbl.text = yogaCentreDetailsTimingsArray.joined(separator: ",")
            self.yogaCentreDetailsdiscountPercentageLbl.text = "\(allValues.discount)"
            self.yogaCentreDetailsImageGalleryArray = allValues.gymnasiumYogaGallery
            self.yogaCentreDetailsImageGalleryArray.removeFirst()
            self.yogaCentreDetailsPlansArray = allValues.gymnasiumYogaPlans
            self.yogaCentreDetailsServicesArray = allValues.gymnasiumYogaServices
            self.yogaCentreDetailsseeServicesBtn.setTitle("See Services: (\((self.yogaCentreDetailsServicesArray.count)))", for: .normal)
            self.yogaCentreDetailsReviewListArray = allValues.reviewsList
            self.yogaCentreDetailsseeReviewsBtn.setTitle("See Reviews: \(allValues.totalReviews)", for: .normal)
            self.latitudeString = allValues.latitude
            self.longitudeString = allValues.longitude
            self.notAvailableDatesString = allValues.notAvailabilityDates
            
            //Condition to hide reviews table in no reviews
            if allValues.totalReviews == 0 {
                self.yogaCentreDetailsseeReviewsBtn.isEnabled = false
            }
            
            //Condition to hide Services in no services present
            if self.yogaCentreDetailsServicesArray.isEmpty {
                self.yogaCentreDetailsseeServicesBtn.isEnabled = false
            }
            
            if allValues.allowBooking == true {
                self.yogaCentreDetailsbookButton.isHidden = false
            }else {
                self.yogaCentreDetailsbookButton.isHidden = true
            }
            
        }
        
    }
    
    
}

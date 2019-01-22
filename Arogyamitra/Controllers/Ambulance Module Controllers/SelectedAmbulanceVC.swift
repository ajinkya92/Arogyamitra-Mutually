//
//  SelectedAmbulanceVC.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 16/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

import UIKit
import Kingfisher
import DLRadioButton
import CoreLocation

class SelectedAmbulanceVC: UIViewController {
    
    //OUTLETS
    @IBOutlet weak var innerContentView: UIView!
    @IBOutlet weak var ambulanceImage: UIImageView!
    @IBOutlet weak var ambulanceTypeLbl: UILabel!
    @IBOutlet weak var ambulanceNameLbl: UILabel!
    @IBOutlet weak var contactNumberBtn: UIButton!
    @IBOutlet weak var driverNameLbl: UILabel!
    @IBOutlet weak var chargesLbl: UILabel!
    @IBOutlet weak var vehicleNumLbl: UILabel!
    @IBOutlet weak var outStationServiceImage: UIImageView!
    @IBOutlet weak var innerContentViewBookBtn: UIButton!
    @IBOutlet weak var innerContentViewCloseBtn: UIButton!
    @IBOutlet weak var innerContentviewRequestInPrecesslbl: UILabel!
    @IBOutlet weak var radioBtn: DLRadioButton!
    
    
    //Small POPUP View Outlets
    @IBOutlet weak var smallPopupView: UIView!
    @IBOutlet weak var registeredAddressLbl: UILabel!
    @IBOutlet weak var currentAddressTxtView: UITextView!
    @IBOutlet weak var smallPopupBookBtn: UIButton!
    
    
    //Animating Outlets - Constratints
    @IBOutlet weak var smallPopupViewCenterShiftConstraint: NSLayoutConstraint!
    
    
    //Location Variables
    var locationManager = CLLocationManager()
    var currentLocation = CLLocationCoordinate2D()
    var currentAddressStringForBooking = String()
    var registeredAddressStringForBooking = String()
    var addressStringToPassForBooking = String()
    var latitudeStringForBooking = String()
    var longitudeStringForBooking = String()
    

    //Storage Variables
    var requiedValuesDictionary = [String:Any]()
    
    //Static Values Passed
    let paymentMode = 3
    let paymentGatewayResponse = "sometext"
    let paymentAmount = 1
    let paymentGateway = 2
    let couponId = ""
    let couponAmount = 5
    let walletAmount = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAllDisplayElements()
        radioBtn.isMultipleSelectionEnabled = false
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.startUpdatingLocation()
        currentAddressTxtView.delegate = self
        
    }
    
    //ACTIONS
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Mobile Number Call Action
    @IBAction func mobileNumberBtnTapped(_ sender: UIButton) {
        let mobileNumber = requiedValuesDictionary["mobileNumber"] as? String
        
        if let mobileNumber = mobileNumber {
            if let url = URL(string: "tel://\(mobileNumber)"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
    
    @IBAction func innerContentViewBookBtnTapped(_ sender: UIButton) {
        
        let buttonTitle = sender.titleLabel?.text
        if let buttonTitle = buttonTitle {
            if buttonTitle == "Book" {
                smallPopupViewCenterShiftConstraint.constant = 0
                innerContentViewBookBtn.setTitle("Processing", for: .normal)
                innerContentViewCloseBtn.isHidden = true
                UIView.animate(withDuration: 1.0) {
                    self.view.layoutIfNeeded()
                }
            }else {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        
    }
    
    //MARK: SMALL POPUP VIEW ACTIONS
    
    @IBAction func smallPopupViewCloseBtnTapped(_ sender: UIButton) {
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            smallPopupViewCenterShiftConstraint.constant = -500
        }else {
            smallPopupViewCenterShiftConstraint.constant = -1200
        }
        
        innerContentViewCloseBtn.isHidden = false
        innerContentViewBookBtn.setTitle("Book", for: .normal)
        
        UIView.animate(withDuration: 1.0) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    @IBAction func radioButtonActions(_ sender: DLRadioButton) {
        //Tag 1 for Registered Address and 2 for Current Address
        
        switch sender.tag {
        case 1:
            //print("Register Button Tag: \(sender.tag)")
            currentAddressTxtView.isHidden = true
            registeredAddressLbl.isHidden = false
            addressStringToPassForBooking = registeredAddressLbl.text ?? ""
            
            let registeredLatitudeValue = requiedValuesDictionary["registeredUserLatitude"] as? String
            if let registeredLatitude = registeredLatitudeValue {
                latitudeStringForBooking = registeredLatitude
            }
            
            let registeredLongitudeValue = requiedValuesDictionary["registeredUserLongitude"] as? String
            if let registeredLongitude = registeredLongitudeValue {
                longitudeStringForBooking = registeredLongitude
            }
            smallPopupBookBtn.tag = 3
            
        case 2:
            //print("Current Address Tag: \(sender.tag)")
            locationManager.startUpdatingLocation()
            currentAddressTxtView.isHidden = false
            registeredAddressLbl.isHidden = true
            currentAddressTxtView.text = currentAddressStringForBooking
            addressStringToPassForBooking = currentAddressTxtView.text
            latitudeStringForBooking = "\(currentLocation.latitude)"
            longitudeStringForBooking = "\(currentLocation.longitude)"
            
            smallPopupBookBtn.tag = 3
            
        default:
            return
        }
        
    }
    
    @IBAction func smallPopupViewBookBtnTapped(_ sender: UIButton) {
        
        if sender.tag == 3 {
            
            //Booking API to be called her
            var patientIdToPass = Int()
            var ambulanceIdToPass = Int()
            
            
            let patientId = requiedValuesDictionary["patientId"] as? Int
            if let patientId = patientId {
                patientIdToPass = patientId
            }
            
            let ambulanceId = requiedValuesDictionary["ambulanceId"] as? Int
            if let ambulanceId = ambulanceId {
                ambulanceIdToPass = ambulanceId
            }
            
            print("Patient Id: \(patientIdToPass), AmbulanceId:\(ambulanceIdToPass), Latitude:\(latitudeStringForBooking), Longitude:\(longitudeStringForBooking), Address String For Booking: \(addressStringToPassForBooking)")
            
            AmbulanceServices.instance.bookNormalAndCardiacAmbulance(patientId: patientIdToPass, ambulanceId: ambulanceIdToPass, pickupAddress: addressStringToPassForBooking, pickupLatitude: latitudeStringForBooking, pickupLongitude: longitudeStringForBooking, paymentMode: paymentMode, paymentGatewayResponse: paymentGatewayResponse, paymentAmount: paymentAmount, paymentGateway: paymentGateway, couponId: couponId, couponAmount: couponAmount, walletAmount: walletAmount) { (success, returnedBookingResponse) in
                
                if let returnedBookingResponse = returnedBookingResponse {
                    print(returnedBookingResponse.message)
                }
                
                DispatchQueue.main.async {
                    
                    //Check If Iphone or Ipad and hide the smallPopupView
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        self.smallPopupViewCenterShiftConstraint.constant = -500
                        self.view.layoutIfNeeded()
                    }else {
                        self.smallPopupViewCenterShiftConstraint.constant = -1200
                        self.view.layoutIfNeeded()
                    }
                    self.innerContentViewBookBtn.setTitle("Go Back", for: .normal)
                    self.innerContentviewRequestInPrecesslbl.isHidden = false
                    
                    
                }
                
            }
            
        }else {
            //print("Put Alert Here")
            let alert = UIAlertController(title: "Please Enter Address", message: "Please Enter Address", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.navigationController?.present(alert, animated: true, completion: nil)
        }
        
    }
    
}

//MARK: Set Display Elements on View Did Load
extension SelectedAmbulanceVC {
    
    func setAllDisplayElements() {
        self.view.makeToastActivity(.center)
        innerContentView.layer.cornerRadius = 5
        guard let ambulanceImageUrl = URL(string: requiedValuesDictionary["ambulanceImage"] as! String) else {return}
        ambulanceImage.kf.setImage(with: ambulanceImageUrl)
        
        if let ambulanceTypeString = requiedValuesDictionary["ambulanceType"] {
            ambulanceTypeLbl.text = "Type - \(ambulanceTypeString as? String ?? "")"
        }
        
        ambulanceNameLbl.text = requiedValuesDictionary["ambulanceName"] as? String
        contactNumberBtn.setTitle(requiedValuesDictionary["mobileNumber"] as? String, for: .normal)
        driverNameLbl.text = requiedValuesDictionary["driverName"] as? String
        
        if let chargesString = requiedValuesDictionary["charges"] {
            chargesLbl.text =  "Rs. \((chargesString as? String ?? ""))/- per km"
        }
        
        if let vehicleNumberString = requiedValuesDictionary["vehicleNumber"] {
            vehicleNumLbl.text = (vehicleNumberString as? String ?? "")
        }
        
        let outOfStationServiceValue = requiedValuesDictionary["outOfStationServices"] as? Int
        
        if let outOfStationServiceValue = outOfStationServiceValue {
            
            if outOfStationServiceValue != 0 {
                outStationServiceImage.image = UIImage(named: "checked")
            }else {outStationServiceImage.image = UIImage(named: "cancelRed")}
            
        }
        
       let registeredAddressString = requiedValuesDictionary["registeredAddressStringToPass"] as? String
        if let registeredAddressValue = registeredAddressString {
            self.registeredAddressLbl.text = registeredAddressValue
        }
        
        innerContentviewRequestInPrecesslbl.isHidden = true
        
        smallPopupView.layer.borderWidth = 1.0
        smallPopupView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        smallPopupView.layer.cornerRadius = 5.0
        smallPopupView.clipsToBounds = true
        
        //Check If Iphone or Ipad and hide the smallPopupView
        if UIDevice.current.userInterfaceIdiom == .phone {
            smallPopupViewCenterShiftConstraint.constant = -500
            self.view.layoutIfNeeded()
        }else {
            smallPopupViewCenterShiftConstraint.constant = -1200
            self.view.layoutIfNeeded()
        }
        
        registeredAddressLbl.isHidden = true
        currentAddressTxtView.isHidden = true
        
        self.view.hideToastActivity()
        
    }
    
}

//MARK: TEXT VIEW IMPLEMENTATION
extension SelectedAmbulanceVC: UITextViewDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    //Using This Text Field Value Pass It to the Booking Page.
    
}

//MARK: Core Location Implementation to Get User Location Coordinates
extension SelectedAmbulanceVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            currentLocation = CLLocationCoordinate2DMake(location.coordinate.latitude,location.coordinate.longitude)
        }
        manager.stopUpdatingLocation()
        getAddressFromLatLon(pdblLatitude: "\(currentLocation.latitude)", withLongitude: "\(currentLocation.longitude)")
        
    }
    
}

//MARK: Custom Functions
extension SelectedAmbulanceVC {
    
    //Reverse Geo Coding Function
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        let lon: Double = Double("\(pdblLongitude)")!
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    
                    var addressString : String = ""
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    
                    self.currentAddressStringForBooking = addressString
                    //print(addressString)
                }
        })
        
    }
    
}

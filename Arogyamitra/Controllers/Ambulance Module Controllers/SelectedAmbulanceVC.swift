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
    var currentLocation: CLLocation!
    var latitudeString = String()
    var longitudeString = String()
    var addressStringForTxtView = String()

    //Storage Variables
    var requiedValuesDictionary = [String:Any]()
    
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
        
        smallPopupViewCenterShiftConstraint.constant = 0
        innerContentViewBookBtn.setTitle("Processing", for: .normal)
        innerContentViewCloseBtn.isHidden = true
        UIView.animate(withDuration: 1.0) {
            self.view.layoutIfNeeded()
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
        if sender.tag == 1 {
            //print("Register Address")
            registeredAddressLbl.text = "This Should Have Address Saved in User Defaults"
            currentAddressTxtView.isHidden = true
            registeredAddressLbl.isHidden = false
        }else {
            //print("Current Address")
            //print(addressStringForTxtView)
            currentAddressTxtView.isHidden = false
            registeredAddressLbl.isHidden = true
            currentAddressTxtView.text = addressStringForTxtView
            
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
        
        
        
        self.view.hideToastActivity()
        
    }
    
}

//MARK: TEXT VIEW IMPLEMENTATION
extension SelectedAmbulanceVC: UITextViewDelegate {
    
}

//MARK: Core Location Implementation to Get User Location Coordinates
extension SelectedAmbulanceVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        latitudeString = "\(latitude)"
        longitudeString = "\(longitude)"
        
        locationManager.stopUpdatingLocation()
        getAddressFromLatLon(pdblLatitude: latitudeString, withLongitude: longitudeString)
    }
    
}

//MARK: Custom Functions
extension SelectedAmbulanceVC {
    
    //Reverse Geo Coding Function
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
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
                    
                    self.addressStringForTxtView = addressString
                    //print(addressString)
                }
        })
        
    }
    
}

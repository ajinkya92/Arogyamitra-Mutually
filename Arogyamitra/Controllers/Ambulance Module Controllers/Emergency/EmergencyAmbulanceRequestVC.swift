//
//  EmergencyAmbulanceRequestVC.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 23/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

import UIKit
import DLRadioButton
import CoreLocation

class EmergencyAmbulanceRequestVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var emergencyAmbulanceBookRequestActivity: UIActivityIndicatorView!
    @IBOutlet weak var activityAndSendingRequestStack: UIStackView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressbarProgressLbl: UILabel!
    @IBOutlet weak var emergencyAmbulanceCancelRequestBtn: UIButton!
    
    
    
    //Emergency Booking Popup Outlets
    @IBOutlet weak var emergencyBookingPopupCenterXConstraint: NSLayoutConstraint!
    @IBOutlet weak var emergencyBookingPopupCloseBtn: UIButton!
    @IBOutlet weak var emergencyBookingPopupRadioBtn: DLRadioButton!
    @IBOutlet weak var emergencyBookingPopupTextView: UITextView!
    @IBOutlet weak var emergencyBookingPopupBookBtn: UIButton!
    
    //Prev Variables
    var registeredAddressString = String()
    
    //Location Variables
    let locationManager = CLLocationManager()
    var currentLocationCoordinates = CLLocationCoordinate2D()
    var currentLocationString = String()
    
    //ProgressView Variables
    let maxTime: Float = 10.0
    var currentTime: Float = 0.0
    
    var time : Float = 0.0
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialViewSetup()
        
    }
    
    //Actions For Emergency Booking Popup View
    
    @IBAction func emergencyBookingPopupCloseBtnTapped(_ sender: UIButton) {
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            emergencyBookingPopupCenterXConstraint.constant = 500
        }else {emergencyBookingPopupCenterXConstraint.constant = 1500}
        
        UIView.animate(withDuration: 1.0) {
            self.view.layoutIfNeeded()
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    @IBAction func emergencyPopupRadioBtnTapped(_ sender: DLRadioButton) {
        //If Tag is 4 then Register Address and if 5 then Current Address
        switch sender.tag {
        case 4:
            emergencyBookingPopupTextView.text = registeredAddressString
            emergencyBookingPopupTextView.isEditable = false
            emergencyBookingPopupBookBtn.tag = 6
        case 5:
            locationManager.startUpdatingLocation()
            emergencyBookingPopupTextView.text = currentLocationString
            emergencyBookingPopupTextView.isEditable = true
            emergencyBookingPopupBookBtn.tag = 6
        default:
            return
        }
        
    }
    
    @IBAction func emergencyPopupBookBtnTapped(_ sender: UIButton) {
        //Here Dismiss the popup and the Start the Progress Bar
        
        if sender.tag == 6 {
           
            if UIDevice.current.userInterfaceIdiom == .phone {
                emergencyBookingPopupCenterXConstraint.constant = 500
            }else {emergencyBookingPopupCenterXConstraint.constant = 1500}
            
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
            activityAndSendingRequestStack.isHidden = false
            progressView.isHidden = false
            emergencyAmbulanceCancelRequestBtn.isHidden = false
            
            //Invalid timer if it is valid
            if (timer?.isValid == true) {
                timer?.invalidate()
            }
            
            time = 0.0
            progressView.setProgress(0.0, animated: true)
            
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateProgress), userInfo: nil, repeats: true)
            
        }else {
            
            let alert = UIAlertController(title: "Please Enter Address", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @objc func updateProgress() {
    
        emergencyAmbulanceBookRequestActivity.startAnimating()
        time += 20.0
        progressView.setProgress(time/100, animated: true)
        progressbarProgressLbl.text = "\(Int(progressView.progress*100))%"
        
        if time >= 100 {
            timer!.invalidate()
            emergencyAmbulanceBookRequestActivity.stopAnimating()
            activityAndSendingRequestStack.isHidden = true
            progressView.isHidden = true
            progressbarProgressLbl.text = ""
            emergencyAmbulanceCancelRequestBtn.isHidden = true
            //EMERGENCY AMBULANCE BOOKING API CALL HERE...
            
        }
        
        
    }
    
    
    //Actions
    
    @IBAction func cancelRequestBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}

extension EmergencyAmbulanceRequestVC {
    
    func initialViewSetup() {
        emergencyBookingPopupCenterXConstraint.constant = 0
        emergencyBookingPopupTextView.delegate = self
        locationManager.delegate = self
        emergencyBookingPopupTextView.text = ""
        locationManager.startUpdatingLocation()
        activityAndSendingRequestStack.isHidden = true
        emergencyAmbulanceBookRequestActivity.hidesWhenStopped = true
        progressView.progress = 0.0
        progressView.layer.cornerRadius = 10.0
        progressbarProgressLbl.text = ""
        progressView.isHidden = true
        emergencyAmbulanceCancelRequestBtn.isHidden = true
        
    }
    
}

//MARK: EMERGENCY BOOKING POPUP TEXT VIEW DELEGATE IMPLEMENTATION
extension EmergencyAmbulanceRequestVC: UITextViewDelegate {
        
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
    
}

//MARK: LOCATION MANAGER DELEGATE IMPLEMENTATION
extension EmergencyAmbulanceRequestVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            currentLocationCoordinates = location.coordinate
        }
        locationManager.stopUpdatingLocation()
        getAddressFromLatLon(pdblLatitude: "\(currentLocationCoordinates.latitude)", withLongitude: "\(currentLocationCoordinates.longitude)")
        
    }
    
}

//MARK: Additional Required Methods
extension EmergencyAmbulanceRequestVC {
    
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
                    
                    self.currentLocationString = addressString
                    //print(addressString)
                }
        })
        
    }
    
}

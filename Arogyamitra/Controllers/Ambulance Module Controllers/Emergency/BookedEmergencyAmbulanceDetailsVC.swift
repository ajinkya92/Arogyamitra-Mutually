//
//  BookedEmergencyAmbulanceDetailsVC.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 25/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

import UIKit
import Kingfisher
import MapKit

class BookedEmergencyAmbulanceDetailsVC: UIViewController {
    
    //OUTLETS
    @IBOutlet weak var ambulanceImage: UIImageView!
    @IBOutlet weak var ambulanceNameLbl: UILabel!
    @IBOutlet weak var driverNameLbl: UILabel!
    @IBOutlet weak var drivarMobileNumberBtn: UIButton!
    @IBOutlet weak var chargesLbl: UILabel!
    @IBOutlet weak var vehicleNumberLbl: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    
    //Storage Variable From Prev View Controller
    var emergencyAmbulanceResultWithRequestNumberArray = [EmergencyAmbulanceByRequestNumberResult]()
    
    //Variables
    var ambulanceId = Int()
    let staticPatientId = 157
    var driverMobileNumber = String()
    var ambulanceServiceName = String()
    var ambulanceDriverName = String()
    var locationManager = CLLocationManager()
    var pointAnnotation:EmergencyAmbulanceAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
    var fetchAmbulanceLocationResultArray = [AmbulanceLocationResult]()
    
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewOnLoad()
        mapView.delegate = self
        timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(self.fetchEmergencyAmbulanceLocation), userInfo: nil, repeats: true)
        
    }
    
    //Actions
    
    @IBAction func mobileNumberBtnTapped(_ sender: UIButton) {
        
        if let url = URL(string: "tel://\(driverMobileNumber)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }

}

extension BookedEmergencyAmbulanceDetailsVC {
    
    func setupViewOnLoad() {
        
        for allValues in self.emergencyAmbulanceResultWithRequestNumberArray {
            
            self.view.makeToastActivity(.center)
            guard let ambulanceImageUrl = URL(string: allValues.ambulancePhoto) else {return}
            self.ambulanceImage.kf.setImage(with: ambulanceImageUrl)
            self.ambulanceNameLbl.text = allValues.ambulanceName
            self.ambulanceServiceName = allValues.ambulanceName
            self.drivarMobileNumberBtn.setTitle(allValues.mobileno, for: .normal)
            self.driverMobileNumber = allValues.mobileno
            self.driverNameLbl.text = allValues.driverName
            self.ambulanceDriverName = allValues.driverName
            self.chargesLbl.text = allValues.chargesPerKM
            self.vehicleNumberLbl.text = allValues.vehicleNo
            self.ambulanceId = allValues.ambulanceID
            setMapAnnotationDetails(withLatitude: (allValues.latitude as NSString).doubleValue, andLongitude: (allValues.longitude as NSString).doubleValue)
            self.view.hideToastActivity()
        }
        
    }
}

    //MARK: MAP IMPLEMENTATION
    extension BookedEmergencyAmbulanceDetailsVC: MKMapViewDelegate {
        
        func setMapAnnotationDetails(withLatitude latitude: Double, andLongitude longitude:Double)  {
            
            let emergencyAmbulanceLatitude = latitude
            let emergencyAmbulanceLongitude = longitude
            
            //print(emergencyAmbulanceLatitude)
            //print(emergencyAmbulanceLongitude)
            
            let location = CLLocationCoordinate2D(latitude: emergencyAmbulanceLatitude, longitude: emergencyAmbulanceLongitude)
            let center = location
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            mapView.setRegion(region, animated: true)
            
            pointAnnotation = EmergencyAmbulanceAnnotation()
            pointAnnotation.emergencyAmbulancePinImageName = "ambulance"
            pointAnnotation.coordinate = location
            pointAnnotation.title = ambulanceServiceName
            pointAnnotation.subtitle = ambulanceDriverName
            
            pinAnnotationView = MKPinAnnotationView(annotation: pointAnnotation, reuseIdentifier: "pin")
            mapView.addAnnotation(pinAnnotationView.annotation!)
            
            print(location.latitude)
            print(location.longitude)
            
        }
    
    
    
    //MARK: - Custom Annotation
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "pin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        let customPointAnnotation = annotation as? EmergencyAmbulanceAnnotation
        annotationView?.image = UIImage(named: (customPointAnnotation?.emergencyAmbulancePinImageName)!)
        
        return annotationView
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

// MARK: API CALL TO GET AMBULANCE CURRENT LOCATION WITH AMBULANCE ID
extension BookedEmergencyAmbulanceDetailsVC {
    
    @objc func fetchEmergencyAmbulanceLocation() {
        
        AmbulanceServices.instance.getAmbulanceLocation(withMultipleAmbulanceIdsString: "\(ambulanceId)", andPatientId: staticPatientId) { (success, returnedAmbulanceLocationresponse) in
            
            if let returnedAmbulanceLocationresponse = returnedAmbulanceLocationresponse {
                
                if returnedAmbulanceLocationresponse.code == 0 {
                    self.fetchAmbulanceLocationResultArray = returnedAmbulanceLocationresponse.results
                    
                    print("FetchEmergecy Amb Method Called`")
                    
                    DispatchQueue.main.async {
                        for values in self.fetchAmbulanceLocationResultArray {
                            self.setMapAnnotationDetails(withLatitude: (values.latitude as NSString).doubleValue, andLongitude: (values.longitude as NSString).doubleValue)
                        }
                    }
                    
                }else {return}
                
            }
            
        }
    }
    
}

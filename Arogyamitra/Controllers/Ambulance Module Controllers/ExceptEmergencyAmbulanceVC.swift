//
//  ExceptEmergencyAmbulanceVC.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 15/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

import UIKit
import MapKit

class ExceptEmergencyAmbulanceVC: UIViewController {
    
    var customAnnotationTag = 0
    
    //Outlets
    @IBOutlet weak var ambulanceListTableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    var timer = Timer()
    
    let usersCurrentLatitude = "19.0659"
    let usersCurrentLongitude = "73.0011"
    let patientId = 157
    var ambulanceTypeId: Int!
    var multipleAmbulanceIdsToPassArray = [Int]()
    
    //Storage Variables
    var ambulanceExceptEmergencyArray = [AmbulanceExceptEmergencyResult]()
    var ambulanceLocationByIdResultArray = [AmbulanceLocationResult]()
    var allAmbulanceLocationsArray = [MultipleUserLocations]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getAmbulanceListExceptEmergency()
        ambulanceListTableView.delegate = self
        ambulanceListTableView.dataSource = self
        mapView.delegate = self
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0, execute: {
            //Call This api in every 10 seconds
            self.timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(ExceptEmergencyAmbulanceVC.getAmbulanceLocationById), userInfo: nil, repeats: true)
            self.timer.fire()
        })
        
    }

}

//MARK: AmbulanceList Tableview Implementation.
extension ExceptEmergencyAmbulanceVC: UITableViewDelegate,  UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ambulanceExceptEmergencyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = ambulanceListTableView.dequeueReusableCell(withIdentifier: "ExceptEmergencyAmbulanceTblCell") as? ExceptEmergencyAmbulanceTblCell else {return UITableViewCell()}
        cell.configureExceptEmergencyAmbulanceTblCell(exceptEmergencyData: ambulanceExceptEmergencyArray[indexPath.row])
        cell.delegate = self
        cell.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("Index Of TableView Clicked: \(indexPath.row)")
        guard let selectedAmbulanceVc = storyboard?.instantiateViewController(withIdentifier: "SelectedAmbulanceVC") as? SelectedAmbulanceVC else {return}
        let individualSelectedValues = ambulanceExceptEmergencyArray[indexPath.row]
        selectedAmbulanceVc.requiedValuesDictionary = ["ambulanceImage": individualSelectedValues.ambulancePhoto, "ambulanceType":individualSelectedValues.ambulanceType, "ambulanceName":individualSelectedValues.ambulanceName, "mobileNumber":individualSelectedValues.mobileno, "driverName":individualSelectedValues.driverName, "charges":individualSelectedValues.chargesPerKM, "vehicleNumber":individualSelectedValues.vehicleNo, "outOfStationServices":individualSelectedValues.outOfStationService, "patientId": patientId, "ambulanceId": individualSelectedValues.ambulanceID]
        self.navigationController?.present(selectedAmbulanceVc, animated: true, completion: nil)
        
    }
    
}

//MARK: ExceptEmergency Table Cell Delegate Implementation
extension ExceptEmergencyAmbulanceVC: ExceptEmergencyAmbulanceTblCellDelegate {
    
    func didTapMobileNumberAt(_ tag: Int) {
        // Mobile Number Button To Call
        if let mobileNumberUrl = URL(string: "tel://\(ambulanceExceptEmergencyArray[tag].mobileno)"), UIApplication.shared.canOpenURL(mobileNumberUrl) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(mobileNumberUrl)
            } else {
                UIApplication.shared.openURL(mobileNumberUrl)
            }
        }
    }
    
}

//MARK: MAP IMPLEMENTATION
extension ExceptEmergencyAmbulanceVC: MKMapViewDelegate {
    
    func setMapAnnotationDetails()  {
        
        for allLocationDetails in self.ambulanceExceptEmergencyArray {
            
            multipleAmbulanceIdsToPassArray.append(allLocationDetails.ambulanceID)
            
            let allLocations = MultipleUserLocations.init(ambulanceName: allLocationDetails.ambulanceName, driverName: allLocationDetails.driverName, latitude: Double("\(allLocationDetails.latitude)")!, longitude: Double("\(allLocationDetails.longitude)")!, charges: allLocationDetails.chargesPerKM, ambulanceImageUrl: allLocationDetails.ambulancePhoto, ambulanceType: allLocationDetails.ambulanceType, contactNumber: allLocationDetails.mobileno, vehicleNumber: allLocationDetails.vehicleNo, outOfServiceValue: allLocationDetails.outOfStationService, bookingStatus: allLocationDetails.bookingStatus, bookingAmount: allLocationDetails.bookingAmount)
            
            allAmbulanceLocationsArray.append(allLocations)
            //print("All Locations Array: \(locations)")
            //print("All Locations Of Ambulances: \(allAmbulanceLocationsArray)")
            
            for location in allAmbulanceLocationsArray {
                //let annotation = MKPointAnnotation()
                let annotation = CustomPointAnnotation()
                annotation.title = location.ambulanceName
                annotation.subtitle = location.driverName
                annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
                annotation.charges = location.charges
                annotation.ambulanceImageUrl = location.ambulanceImageUrl
                annotation.ambulanceType = location.ambulanceType
                annotation.contactNumber = location.contactNumber
                annotation.vehicleNumber = location.vehicleNumber
                annotation.outOfServiceValue = location.outOfServiceValue
                annotation.ambulanceName = location.ambulanceName
                annotation.driverName = location.driverName
                mapView.addAnnotation(annotation)
                
            }

        }
        
        
        let latitude = (usersCurrentLatitude as NSString).doubleValue
        let longitude = (usersCurrentLongitude as NSString).doubleValue
        
        let latDelta:CLLocationDegrees = 0.01
        
        let lonDelta:CLLocationDegrees = 0.01
        
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
    
    //Set Annotation Pin To Ambulance
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // Don't want to show a custom image if the annotation is the user's location.
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        // Better to make this class property
        let annotationIdentifier = "AnnotationIdentifier"
        
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        if let annotationView = annotationView {
            // Configure your annotation view here
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "ambulance")
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if control == view.rightCalloutAccessoryView {
            
            if let customAnnotation = view.annotation as? CustomPointAnnotation {
                
                guard let selectedAmbulanceVc = storyboard?.instantiateViewController(withIdentifier: "SelectedAmbulanceVC") as? SelectedAmbulanceVC else {return}
                selectedAmbulanceVc.requiedValuesDictionary = ["ambulanceImage": customAnnotation.ambulanceImageUrl, "ambulanceType":customAnnotation.ambulanceType, "ambulanceName":customAnnotation.ambulanceName, "mobileNumber":customAnnotation.contactNumber, "driverName":customAnnotation.driverName, "charges":customAnnotation.charges, "vehicleNumber":customAnnotation.vehicleNumber, "outOfStationServices":customAnnotation.outOfServiceValue]
                self.navigationController?.present(selectedAmbulanceVc, animated: true, completion: nil)
                
                
            }
            
        }
    }
    
}


//MARK: API CALLS GO HERE
extension ExceptEmergencyAmbulanceVC {
    
    //MARK: API CALL TO GET AMBULANCE LIST EXCEPT EMERGENCY
    
    func getAmbulanceListExceptEmergency() {
        
        //self.view.makeToastActivity(.center)
        AmbulanceServices.instance.getAmbulanceListExceptExergency(withAmbulanceTypeId: ambulanceTypeId, userCurrentLatitude: usersCurrentLatitude, userCurrentLongitude: usersCurrentLongitude, patientId: patientId) { (success, returnedAmbulanceResponse) in
            
            if let returnedAmbulanceResponse = returnedAmbulanceResponse {
                self.ambulanceExceptEmergencyArray = returnedAmbulanceResponse.results
            }
            
            DispatchQueue.main.async {
                self.ambulanceListTableView.reloadData()
                self.setMapAnnotationDetails()
                //self.view.hideToastActivity()
            }
            
            //print("Ambulance List Except Emergency Ambulance: \(self.ambulanceExceptEmergencyArray)")
            
        }
    }
    
    //MARK: API CALL TO GET AMBULANCE LOCATION BY ID
    
    @objc func getAmbulanceLocationById() {
        
        let multipleAmbulanceIdString = multipleAmbulanceIdsToPassArray.map({String($0)}).joined(separator: ",")
        AmbulanceServices.instance.getAmbulanceLocation(withMultipleAmbulanceIdsString: multipleAmbulanceIdString, andPatientId: patientId) { (success, returnedAmbulanceLocationData) in
            
            if let returnedAmbulanceLocationData = returnedAmbulanceLocationData {
                self.ambulanceLocationByIdResultArray = returnedAmbulanceLocationData.results
            }
            
            DispatchQueue.main.async {
                self.getAmbulanceListExceptEmergency()
            }
            
        }
        
        //print("Ambulance Location By Id Array: \(self.ambulanceLocationByIdResultArray)")
        
        
    }
    
}

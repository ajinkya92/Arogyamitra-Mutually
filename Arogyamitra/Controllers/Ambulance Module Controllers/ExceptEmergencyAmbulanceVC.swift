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
    
    //Outlets
    @IBOutlet weak var ambulanceListTableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    let usersCurrentLatitude = "19.0659"
    let usersCurrentLongitude = "73.0011"
    let patientId = 157
    var ambulanceTypeId: Int!
    
    //Storage Variables
    var ambulanceExceptEmergencyArray = [AmbulanceExceptEmergencyResult]()
    var allAmbulanceLocationsArray = [MultipleUserLocations]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getAmbulanceListExceptEmergency()
        ambulanceListTableView.delegate = self
        ambulanceListTableView.dataSource = self
        mapView.delegate = self
        
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
        selectedAmbulanceVc.requiedValuesDictionary = ["ambulanceImage": individualSelectedValues.ambulancePhoto, "ambulanceType":individualSelectedValues.ambulanceType, "ambulanceName":individualSelectedValues.ambulanceName, "mobileNumber":individualSelectedValues.mobileno, "driverName":individualSelectedValues.driverName, "charges":individualSelectedValues.chargesPerKM, "vehicleNumber":individualSelectedValues.vehicleNo, "outOfStationServices":individualSelectedValues.outOfStationService]
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
            
            let allLocations = MultipleUserLocations.init(ambulanceName: allLocationDetails.ambulanceName, driverName: allLocationDetails.driverName, latitude: Double("\(allLocationDetails.latitude)")!, longitude: Double("\(allLocationDetails.longitude)")!)
            
            allAmbulanceLocationsArray.append(allLocations)
            //print("All Locations Array: \(locations)")
            //print("All Locations Of Ambulances: \(allAmbulanceLocationsArray)")
            
            for location in allAmbulanceLocationsArray {
                let annotation = MKPointAnnotation()
                annotation.title = location.ambulanceName
                annotation.subtitle = location.driverName
                annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
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
    
}


//MARK: API CALL TO GET AMBULANCE LIST EXCEPT EMERGENCY
extension ExceptEmergencyAmbulanceVC {
    
    func getAmbulanceListExceptEmergency() {
        
        self.view.makeToastActivity(.center)
        AmbulanceServices.instance.getAmbulanceListExceptExergency(withAmbulanceTypeId: ambulanceTypeId, userCurrentLatitude: usersCurrentLatitude, userCurrentLongitude: usersCurrentLongitude, patientId: patientId) { (success, returnedAmbulanceResponse) in
            
            if let returnedAmbulanceResponse = returnedAmbulanceResponse {
                self.ambulanceExceptEmergencyArray = returnedAmbulanceResponse.results
            }
            
            DispatchQueue.main.async {
                self.ambulanceListTableView.reloadData()
                self.setMapAnnotationDetails()
                self.view.hideToastActivity()
            }
            
            //print("Ambulance List Except Emergency Ambulance: \(self.ambulanceExceptEmergencyArray)")
        }
    }
    
}

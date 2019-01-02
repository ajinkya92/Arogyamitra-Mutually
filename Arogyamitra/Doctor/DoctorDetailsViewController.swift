//
//  DoctorDetailsViewController.swift
//  Arogyamitra
//
//  Created by Nitin Landge on 12/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import UIKit
import MapKit

class DoctorDetailsViewController: UIViewController {
    @IBOutlet weak var imageView_image1: UIImageView!
    @IBOutlet weak var imageView_image2: UIImageView!
    @IBOutlet weak var imageView_image3: UIImageView!
    @IBOutlet weak var imageView_image4: UIImageView!
    @IBOutlet weak var imageView_image5: UIImageView!
    @IBOutlet weak var imageView_drImage: UIImageView!

    @IBOutlet weak var mapView: MKMapView!
    let annotation = MKPointAnnotation()

    @IBOutlet weak var label_drName: UILabel!
    @IBOutlet weak var label_hospitalName: UILabel!
    @IBOutlet weak var label_experence: UILabel!
    @IBOutlet weak var label_degree: UILabel!
    @IBOutlet weak var label_address: UILabel!
    @IBOutlet weak var label_avaliableOn: UILabel!
    @IBOutlet weak var label_opdFees: UILabel!

    @IBOutlet weak var btn_seeServices: UIButton!
    @IBOutlet weak var btn_seeReview: UIButton!
    
    @IBOutlet weak var label_percentageOff: UILabel!
    
    @IBOutlet weak var height_tableView: NSLayoutConstraint!
    @IBOutlet weak var height_offerCardView: NSLayoutConstraint!
    
    @IBOutlet weak var btn_like: UIButton!
    var arr_doctorDetails = [DoctorDetails]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        doctorDetailsAPICall()
    }
    
    func setDoctorDetails()
    {
        let data = arr_doctorDetails.first
        let latitude =  (data?.latitude as NSString?)?.doubleValue
        let longitude = (data?.longitude as NSString?)?.doubleValue
        
        if latitude != nil{
            annotation.coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
            mapView.addAnnotation(annotation)
            let latDelta:CLLocationDegrees = 0.05
            let lonDelta:CLLocationDegrees = 0.05
            let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
            let location = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
            let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: false)
        }
        
        let imageStr = data?.hospital_background_photo!
        imageView_image1.kf.setImage(with: URL(string:imageStr!
            .replacingOccurrences(of: " ", with: "%20")), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)

        imageView_drImage.kf.setImage(with: URL(string:(data?.doctor_photo!
            .replacingOccurrences(of: " ", with: "%20"))!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)

        label_drName.text = data?.doctor_name ?? ""
        label_experence.text = data?.experience ?? ""
        label_address.text = data?.hospital_address ?? ""
        label_avaliableOn.text = avaliableDays(days: (data?.days_availability)!) + ":"
//        btn_seeReview.setTitle(data??.review_exists, for: .normal)
        
        let servicesCount = String(describing: (data?.hospital_services?.count)!)
        btn_seeServices.setTitle("See Services " + "(" + servicesCount + ")", for: .normal)
        
        let reviewCount = String(describing: (data?.total_reviews)!)
        btn_seeReview.setTitle("See Reviews " + "(" + reviewCount + ")", for: .normal)
        
//        doctor_timings
        for arr in (data?.doctor_timings)!
        {
            let timings =  (arr.open_time!) + "-" + (arr.close_time!) + ","
            label_avaliableOn.text?.append(timings)
        }
      
        label_degree.text = ""
        for arr in (data?.degree)!
        {
            let degree =  (arr.degree_name!)  + ","
            label_degree.text?.append(degree)
        }
        
        label_opdFees.text = String(describing: (data?.fees!)!) + "/-"
        label_hospitalName.text = "(" + String(describing: (data?.hospital_name!)!) + ")"
        
        if data?.favourite == true {
            btn_like.setImage(#imageLiteral(resourceName: "like_select"), for: .normal)
        }else{
            btn_like.setImage(#imageLiteral(resourceName: "like_deSelect"), for: .normal)
        }
    }
    
    //MARK: Button Action
    
    @IBAction func btn_likePressed(_ sender: Any) {
        
        doctorLikeAPICall(doctorId: (arr_doctorDetails.first?.doctor_id)!)

    }
    @IBAction func btn_writeReviewPressed(_ sender: Any)
    {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "RatingAndReviewViewController") as! RatingAndReviewViewController
        viewController.arr_doctorDetails = arr_doctorDetails
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func btn_seeReviewPressed(_ sender: Any)
    {
    }
    @IBAction func btn_seeServicesPressed(_ sender: Any)
    {
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
        return log2(360 * ((width / 256) / spanStraight)) + 1;
    }
}

extension DoctorDetailsViewController{
    
    func doctorDetailsAPICall()
    {
        self.view.makeToastActivity(.center)
        let url = UrlString().getDoctorDeatilsBySpecialityURL()
        WebserviceHelper.sharedInstance.getData(URL: url, parameterDict: getDoctorDeatilsParam(doctorHospitalId: 1), methodType: .post, headerDict: getheader(), Encoding: URLEncoding.default, successBlock:{
            (responseData) in
            do
            {
                let doctorDetailsData = try JSONDecoder().decode(DoctorDetailsModel.self, from: responseData!)
                
                if doctorDetailsData.results != nil
                {
                    self.arr_doctorDetails = doctorDetailsData.results!
                    self.setDoctorDetails()
                }
            }
            catch
            {
                print(error)
            }
            
            self.view.hideToastActivity()
            
            
        }, failureMessage: {
            (failureMessage) in
            // Show Failure Message
            self.view.hideToastActivity()
            
            //            self.view?.makeToast(failureMessage, duration: "toastTimeDuration", position: .center)
            
        })
    }
    
    func doctorLikeAPICall(doctorId: Int)
    {
        self.view.makeToastActivity(.center)
        let url = UrlString().doctorFavouriteURL()
        
        
        WebserviceHelper.sharedInstance.getData(URL: url, parameterDict: getFavParam(doctorId: doctorId, patientId: "157"), methodType: .post, headerDict: getheader() , Encoding: JSONEncoding.default, successBlock:{
            (responseData) in
            do
            {
                let data = try JSONDecoder().decode(DoctorFavModel.self, from: responseData!)
                
                if data.code == 1
                {
                    self.btn_like.setImage(#imageLiteral(resourceName: "like_select"), for: .normal)
                }else if data.code == 0 {
                    self.btn_like.setImage(#imageLiteral(resourceName: "like_deSelect"), for: .normal)
                }
         
            }
            catch
            {
                print(error)
            }
            
            self.view.hideToastActivity()
            
            
        }, failureMessage: {
            (failureMessage) in
            // Show Failure Message
            self.view.hideToastActivity()
            
            //            self.view?.makeToast(failureMessage, duration: "toastTimeDuration", position: .center)
            
        })
    }
}

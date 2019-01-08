//
//  HospitalDetailsViewController.swift
//  Arogyamitra
//
//  Created by Nitin Landge on 13/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import UIKit
import Kingfisher
import MapKit


class HospitalDetailsViewController: UIViewController {
    @IBOutlet weak var imageView_bgImage: UIImageView!
    @IBOutlet weak var label_address: UILabel!
    @IBOutlet weak var label_mobNumber: UILabel!
    @IBOutlet weak var label_email: UILabel!
    @IBOutlet weak var label_website: UILabel!
    @IBOutlet weak var label_dayesAvaliable: UILabel!
    @IBOutlet weak var label_avaliableTiming: UILabel!
    @IBOutlet weak var btn_seeServices: UIButton!
    @IBOutlet weak var btn_seeReviews: UIButton!
    
    @IBOutlet weak var tableView_height: NSLayoutConstraint!

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var mapView: MKMapView!
    let annotation = MKPointAnnotation()
    
    var arr_hospitalDetails = [HospitalDetailsResult]()
    var arr_hospitalSpecialityDetails = [Speciality_list]()
    
    var hospitalID = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        hospitalDetailsAPICall()
    }
    
    
    //tableview auto size
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        tableView.layer.removeAllAnimations()
        tableView_height.constant = tableView.contentSize.height
        UIView.animate(withDuration: 0.5) {
            self.tableView.updateConstraints()
            self.tableView.layoutIfNeeded()
        }
    }
    

    
    func setDetails()  {
        
        let latitude =  (arr_hospitalDetails.first?.latitude as NSString?)?.doubleValue
        let longitude = (arr_hospitalDetails.first?.longitude as NSString?)?.doubleValue
        
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

        
        let imageStr = arr_hospitalDetails.first?.hospital_background_photo!
        if imageStr != nil{
            imageView_bgImage.kf.setImage(with: URL(string:imageStr!
                .replacingOccurrences(of: " ", with: "%20")), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        }
        label_address.text = arr_hospitalDetails.first?.address
        label_mobNumber.text =  arr_hospitalDetails.first?.phone_no
        label_email.text =  arr_hospitalDetails.first?.emailid
        label_website.text =  arr_hospitalDetails.first?.website_url
        if arr_hospitalDetails.first?.days_availability?.count ?? 0 > 0{
            label_dayesAvaliable.text = avaliableDays(days: (arr_hospitalDetails.first?.days_availability)!)
        }
        label_avaliableTiming.text = ""
        
        let servicesCount = String(describing: (arr_hospitalDetails.first?.hospital_services?.count)!)
        btn_seeServices.setTitle("See Services " + "(" + servicesCount + ")", for: .normal)

        let reviewCount = String(describing: (arr_hospitalDetails.first?.total_reviews)!)
        btn_seeReviews.setTitle("See Reviews " + "(" + reviewCount + ")", for: .normal)
        
        for arr in (arr_hospitalDetails.first?.hospital_timings)!
        {
            let timings =  (arr.open_time!) + "-" + (arr.close_time!) + ","
            label_avaliableTiming.text?.append(timings)
        }
        
        //set hospital_gallery here (4 pics)
    }
    
    @IBAction func btn_mobileNoPressed(_ sender: Any) {
        callingNumber(phoneNumber: label_mobNumber.text!)
        
    }
    
    @IBAction func btn_writeReviewPressed(_ sender: Any) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "RatingAndReviewViewController") as! RatingAndReviewViewController
        viewController.arr_hospitalDetails = arr_hospitalDetails
        viewController.isFromHospital = true
        self.navigationController?.pushViewController(viewController, animated: true)
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

extension HospitalDetailsViewController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arr_hospitalSpecialityDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DoctorTableViewCell
       
        let data = arr_hospitalSpecialityDetails[indexPath.row]
        cell.setDoctorData(data: data)
        tableView.separatorColor = UIColor.clear
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
//        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "DoctorDetailsViewController") as! DoctorDetailsViewController
//        self.navigationController?.pushViewController(viewController, animated: true)
    }

}


extension HospitalDetailsViewController{
    
    func hospitalDetailsAPICall()
    {
        self.view.makeToastActivity(.center)
        let url = UrlString().getHospitalDetailsURL()
        
        
        WebserviceHelper.sharedInstance.getData(URL: url, parameterDict: getHospitalDeatilsParam(hospitalId: String(hospitalID), patientId: "157"), methodType: .post, headerDict: getheader(), Encoding: URLEncoding.default, successBlock:{
            (responseData) in
            do
            {
                let arr_hospitalDetails = try JSONDecoder().decode(HospitalDetailsModel.self, from: responseData!)
                
                if arr_hospitalDetails.results != nil
                {
                    self.arr_hospitalDetails = arr_hospitalDetails.results!
                    self.setDetails()
//                    self.tableView.reloadData()
                }
            }
            catch
            {
                print(error)
            }
            
            self.getSpecialityListByHospital_id_APICall()

            self.view.hideToastActivity()
            
            
        }, failureMessage: {
            (failureMessage) in
            // Show Failure Message
            self.view.hideToastActivity()
            
            //            self.view?.makeToast(failureMessage, duration: "toastTimeDuration", position: .center)
            
        })
    }
    
    
    func getSpecialityListByHospital_id_APICall()
    {
        self.view.makeToastActivity(.center)
        let url = UrlString().get_speciality_list_by_hospital_id_URL()
        
        
        WebserviceHelper.sharedInstance.getData(URL: url, parameterDict: getSpecialityListByHospital(hospitalId:  String(hospitalID)), methodType: .post, headerDict: getheader(), Encoding: URLEncoding.default, successBlock:{
            (responseData) in
            do
            {
                let arr_speciality = try JSONDecoder().decode(HospitalDetailsSpecialityModel.self, from: responseData!)
                
                if arr_speciality.results != nil
                {
                    self.arr_hospitalSpecialityDetails = arr_speciality.results!
                    self.setDetails()
                    self.tableView.reloadData()
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

//
//  LaboratoryDetailsViewController.swift
//  Arogyamitra
//
//  Created by Sangram Powar on 29/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import UIKit
import MapKit


class LaboratoryDetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView_labImage: CustomCircularImage!
    @IBOutlet weak var imageView_labBg: UIImageView!
    @IBOutlet weak var label_labName: UILabel!
    @IBOutlet weak var label_labAddress: UILabel!
    @IBOutlet weak var label_timeAvalible: UILabel!
    @IBOutlet weak var label_daysAvaliable: UILabel!
    @IBOutlet weak var label_mobNo: UILabel!
    @IBOutlet weak var label_email: UILabel!
    
    @IBOutlet weak var discountOnlinePayment: UILabel!
    @IBOutlet weak var btn_seeReviews: UIButton!
   
    @IBOutlet weak var mapView: MKMapView!
    let annotation = MKPointAnnotation()

    var arr_laboratoryDetails = [LaboratoryDetailsResult]()
    
    var arr_testScanList = [Test_scan_list2]()
    var labScanId = 0
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LaboratoryDetailsAPICall(labScanId: String(labScanId))
        
    }
    
    @IBAction func btn_writeReviewPressed(_ sender: Any) {
    }
    
    func setLabDetails()
    {
        let data = arr_laboratoryDetails.first
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
        
        imageView_labBg.kf.setImage(with: URL(string:(data?.photo!
            .replacingOccurrences(of: " ", with: "%20"))!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        
        
        label_labName.text = data?.name ?? ""
      
        label_mobNo.text = data?.mobileno ?? ""
        label_email.text = data?.emailid ?? ""

        label_labAddress.text = data?.address ?? ""
        label_daysAvaliable.text = avaliableDays(days: (data?.days_availability)!) + ":"

        let reviewCount = String(describing: (data?.total_reviews)!)
        btn_seeReviews.setTitle("See Reviews " + "(" + reviewCount + ")", for: .normal)
        
        label_timeAvalible.text = ""
        let timings =  ((data?.opentime!)!) + "-" + ((data?.closetime!)!)
        label_timeAvalible.text?.append(timings)
        

    }
    
}
extension LaboratoryDetailsViewController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if arr_testScanList.count > 0
        {
            return arr_testScanList.count

        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LabTestScanListTableViewCell
        if arr_testScanList.count > 0{
            let data = arr_testScanList[indexPath.row]
            cell.setLabTestList(data: data)
        }
        
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


extension LaboratoryDetailsViewController{
    
    func LaboratoryDetailsAPICall(labScanId: String)
    {
        self.view.makeToastActivity(.center)
        let url = UrlString().getLaboratoryScanDetailsURL()
        WebserviceHelper.sharedInstance.getData(URL: url, parameterDict: getLabrDeatilsParam(laboratory_scan_id: labScanId), methodType: .post, headerDict: getheader(), Encoding: URLEncoding.default, successBlock:{
            (responseData) in
            do
            {
                let labDetails = try JSONDecoder().decode(LaboratoryDetailsModel.self, from: responseData!)
                
                if labDetails.results != nil
                {
                    self.arr_laboratoryDetails = labDetails.results!
//                    self.arr_testScanList = (labDetails.results?.first?.test_scan_list)!
                    if self.arr_laboratoryDetails.count > 0
                    {
                        self.setLabDetails()

                    }
                    
//                    self.tableView.reloadData()
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

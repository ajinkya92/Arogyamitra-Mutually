//
//  HospitalListTableViewCell.swift
//  Arogyamitra
//
//  Created by Nitin Landge on 16/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import UIKit

class HospitalListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageView_hospitalImage: CustomCircularImage!
    @IBOutlet weak var label_hospitalName: UILabel!
    @IBOutlet weak var label_hospitalAddress: UILabel!
    @IBOutlet weak var label_is_24hrs: UILabel!
    @IBOutlet weak var label_avaliableDays: UILabel!
    
    @IBOutlet weak var label_services1: UILabel!
    @IBOutlet weak var label_services2: UILabel!
    
    @IBOutlet weak var btn_totalServices: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setHospitalData(data : HospitalResult)
    {
        imageView_hospitalImage.kf.setImage(with: URL(string:data.hospital_photo!
            .replacingOccurrences(of: " ", with: "%20")), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        
        label_hospitalName.text = data.hospital_name
        label_hospitalAddress.text = data.address
        label_avaliableDays.text = avaliableDays(days: data.days_availability!)
        
        if data.hospital_services?[0].services != nil
        {
            label_services1.text = data.hospital_services?[0].services
        }
        if (data.hospital_services?.count)! > 1
        {
             label_services2.text = data.hospital_services?[1].services
        }else{
            label_services2.isHidden = true
            btn_totalServices.isHidden = true
        }
        
        if (data.hospital_services?.count)! > 2
        {
            let count = (data.hospital_services?.count)
            btn_totalServices.setTitle(String("+" + String(count! - 2) + " More"), for: .normal)
        }


    }
    
    

}


/*
 
 "hospital_id": 1154,
 "hospital_photo": "https://arogyamitra.net/doctor/images/default_product.png",
 "hospital_name": "Gaurav",
 "hospital_services": [
 {
 "services": "Contraception Advice"
 }
 ],
 "address": "Vashi, Navi Mumbai, Maharashtra, India",
 "city": 0,
 "city_name": null,
 "country": null,
 "pincode": "400072",
 "parent_name": "kanda",
 "phone_no": "9898989898",
 "emailid": "msgmsg@gmail.com",
 "website_url": "www.arogyamitra.net",
 "fax": "",
 "status": "1",
 "is_24hrs": "yes",
 "hospital_timings": [
 {
 "open_time": "06:00 am",
 "close_time": "08:30 pm"
 }
 ],
 "hospital_speciality": [
 {
 "speciality_id": 31,
 "name": "Cardio thoracic Surgeon",
 "photo": "https://arogyamitra.net/doctor/images/speciality/CV1532781128.jpg"
 },
 {
 "speciality_id": 42,
 "name": "Breast Cancer Specialist ",
 "photo": "https://arogyamitra.net/doctor/images/speciality/Br1532781064.jpeg"
 },
 {
 "speciality_id": 40,
 "name": "Chest Physician ",
 "photo": "https://arogyamitra.net/doctor/images/speciality/Chest1532781262.jpeg"
 },
 {
 "speciality_id": 45,
 "name": "Dermatologist ",
 "photo": "https://arogyamitra.net/doctor/images/speciality/SS1532781547.jpg"
 }
 ],
 "doctorlist": [
 {
 "doctor_id": 78,
 "doctor_hospital_id": 132,
 "doctor_name": "Ramesh Mahajan",
 "doctor_photo": "https://arogyamitra.net/doctor/images/default_product.png",
 "address": "Kalpataru Nagar, Nashik, Maharashtra, India",
 "experience": "",
 "fees": "500",
 "discount": "5",
 "days_availability": "",
 "degree": [
 {
 "degree_name": "BDS"
 },
 {
 "degree_name": "MDS"
 }
 ],
 "doctor_timings": [
 {
 "doctor_hospital_timing_id": 397,
 "open_time": "06:00 am",
 "close_time": "07:00 am",
 "no_of_bookings": 5
 },
 {
 "doctor_hospital_timing_id": 398,
 "open_time": "08:00 am",
 "close_time": "08:00 am",
 "no_of_bookings": 5
 }
 ]
 }
 ],
 "distance": 3.2,
 "average_rating": 2.5,
 "days_availability": "1,2,3",
 "not_availability_dates": ""
 
 */

//
//  DoctorDetails.swift
//  Arogyamitra
//
//  Created by Sangram Powar on 20/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import Foundation

class DoctorDetailsModel: Decodable
{
    var code : Int?
    var status : String?
    var message : String?
    var results : [DoctorDetails]?
}

class DoctorDetails: Decodable {
    let doctor_hospital_id : Int?
    let hospital_id : Int?
    let hospital_name : String?
    let hospital_photo : String?
    let hospital_background_photo : String?
    let hospital_phone_no : String?
    let hospital_emailid : String?
    let hospital_website_url : String?
    let hospital_fax : String?
    let hospital_address : String?
    let hospital_services : [HospitalServices]?
    let latitude : String?
    let longitude : String?
    let doctor_id : Int?
    let doctor_name : String?
    let doctor_photo : String?
    let doctor_speciality : String?
    let doctor_services : [String]?
    let address : String?
    let emailid : String?
    let mobileno : String?
    let experience : String?
    let fees : Int?
    let discount : Int?
    let days_availability : String?
    let not_availability_dates : String?
    let accept_online_payment : Bool?
    let allow_discount : Bool?
    let allow_booking : Bool?
    let favourite : Bool?
    let degree : [Degree]?
    let doctor_timings : [DoctorTimings]?
    let is_booked : Bool?
    let hospitals_attached : [String]?
    let average_rating : Int?
    let total_reviews : Int?
    let reviews_list : [String]?
    let review_exists : Bool?
    let hospital_gallery : [HospitalGallery]?
    let scans_center_list : [String]?
    let labs_list : [String]?
}

//class DoctorTimings : Decodable {
//    var services : String?
//}

class HospitalGallery : Decodable {
    var doctor_hospital_timing_id : Int?
    var open_time : String?
    var close_time : String?
    var no_of_bookings : Int?
}

//class DoctorDegree : Decodable {
//    var degree_name : String?
//}

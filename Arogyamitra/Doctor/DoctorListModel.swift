//
//  DoctorListModel.swift
//  Arogyamitra
//
//  Created by Sangram Powar on 20/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import Foundation

class DoctorListModel: Decodable
{
    var code : Int?
    var status : String?
    var message : String?
    var results : [DoctorResultList]?
}

class DoctorResultList: Decodable {
    var doctor_hospital_id : Int?
    var hospital_id : Int?
    var hospital_name : String?
    var hospital_photo : String?
    var hospital_city : String?
    var doctor_id : Int?
    var doctor_name : String?
    var doctor_speciality : String?
    var hospital_services : [HospitalServices]?
    var doctor_services : [String]?
    var photo : String?
    var address : String?
    var experience : String?
    var fees : Int?
    var discount : Int?
    var days_availability : String?
    var not_availability_dates : String?
    var accept_online_payment : Bool?
    var allow_discount : Bool?
    var allow_booking : Bool?
    var favourite : Bool?
    var degree : [DoctorDegree]?
    var doctor_timings : [DoctorTimings]?
//    var distance : Int?
    var average_rating : Int?
}

class HospitalServices : Decodable {
    var services : String?
}

class DoctorTimings : Decodable {
    var doctor_hospital_timing_id : Int?
    var open_time : String?
    var close_time : String?
    var no_of_bookings : Int?
}

class DoctorDegree : Decodable {
    var degree_name : String?
}


//LIKE
class DoctorFavModel: Decodable
{
    var code : Int?
    var status : String?
    var message : String?
}

//
//  HospitalListModel.swift
//  Arogyamitra
//
//  Created by Nitin Landge on 16/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import Foundation

class HospitalListModel: Decodable
{
    var code : Int?
    var status : String?
    var message : String?
    var results : [HospitalResult]?
}
class HospitalResult : Decodable
{
    var hospital_id : Int?
    var hospital_photo : String?
    var hospital_name : String?
    var hospital_services : [Hospital_services]?
    var address : String?
    var city : Int?
    var city_name : String?
    var country : String?
    var pincode : String?
    var parent_name : String?
    var phone_no : String?
    var emailid : String?
    var website_url : String?
    var fax : String?
    var status : String?
    var is_24hrs : String?
    var hospital_timings : [Hospital_timings]?
    var hospital_speciality : [Hospital_speciality]?
    var doctorlist : [Doctorlist]?
    var distance : Double?
    var average_rating : Double?
    var days_availability : String?
    var not_availability_dates : String?
}
class Hospital_services : Decodable {
    var services : String?
}
class Hospital_timings : Decodable {
    var open_time : String?
    var close_time : String?
    
}
class Hospital_speciality : Decodable {
    var speciality_id : Int?
    var name : String?
    var photo : String?
}
class Doctorlist : Decodable {
    var doctor_id : Int?
    var doctor_hospital_id : Int?
    var doctor_name : String?
    var doctor_photo : String?
    var address : String?
    var experience : String?
    var fees : String?
    var discount : String?
    var days_availability : String?
    var degree : [Degree]?
    var doctor_timings : [Doctor_timings]?
    
//    var accept_online_payment : Bool?

}
class Doctorlist2 : Decodable {
    var doctor_id : String?
    var doctor_hospital_id : String?
    var doctor_name : String?
    var doctor_photo : String?
    var address : String?
    var experience : String?
    var fees : String?
    var discount : String?
    var days_availability : String?
    var degree : [Degree]?
    var doctor_timings : [Doctor_timings]?
    
    //    var accept_online_payment : Bool?
    
}

class Degree : Decodable {
    var degree_name : String?
}
class Doctor_timings : Decodable {
    var doctor_hospital_timing_id : Int?
    var open_time : String?
    var close_time : String?
    var no_of_bookings : Int?
}

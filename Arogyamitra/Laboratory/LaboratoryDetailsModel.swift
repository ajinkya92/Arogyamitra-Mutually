//
//  LaboratoryDetailsModel.swift
//  Arogyamitra
//
//  Created by Sangram Powar on 29/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import Foundation


class LaboratoryDetailsModel: Decodable
{
    var code : Int?
    var status : String?
    var message : String?
    var results : [LaboratoryDetailsResult]?
}
class LaboratoryDetailsResult: Decodable
{
    var laboratory_scan_id : Int?
    var type_id : Int?
    var type_name : String?
    var photo : String?
    var name : String?
    var emailid : String?
    var emailid_multiple : String?
    var address : String?
    var latitude : String?
    var longitude : String?
    var mobileno : String?
    var mobileno_multiple : String?
    var city_id : Int?
    var city_name : String?
    var opentime : String?
    var closetime : String?
    var nabl_approved : Bool?
    var home_pickup : Bool?
    var discount_allow : Bool?
    var discount : Int?
    var accept_online_payment : Bool?
    var days_availability : String?
    var not_availability_dates : String?
    var test_scan_list : [Test_scan_list2]?
    var booking_time_list : [Booking_time_list]?
    var average_rating : Int?
    var total_reviews : Int?
    var reviews_list : [Reviews_list]?
    var review_exists : Bool?
    var allow_booking : Bool?
    var laboratory_scan_gallery : [Laboratory_scan_gallery]?
}

class Booking_time_list : Decodable {
    var booking_time_slots : String?
}

class Laboratory_scan_gallery : Decodable {
    var photo : String?
}
class Test_scan_list2 : Decodable {
    var laboratory_scan_costing_id : Int?
    var test_scan_id : Int?
    var name : String?
    var amount : Int?
    var is_default : Int?
}

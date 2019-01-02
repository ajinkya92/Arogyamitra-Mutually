
//
//  LaboratoryModel.swift
//  Arogyamitra
//
//  Created by Sangram Powar on 27/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import Foundation

class LaboratoryModel: Decodable
{
    var code : Int?
    var status : String?
    var message : String?
    var results : [LaboratoryResult]?
}
class LaboratoryResult: Decodable
{
    var laboratory_scan_id : Int?
    var type_id : Int?
    var type_name : String?
    var photo : String?
    var name : String?
    var address : String?
    var mobileno : String?
    var mobileno_multiple : String?
    var emailid : String?
    var emailid_multiple : String?
    var city_id : String?
    var city_name : String?
    var opentime : String?
    var closetime : String?
    var nabl_approved : Bool?
    var home_pickup : Bool?
    var discount_allow : Bool?
    var discount : Int?
    var accept_online_payment : Bool?
    var test_scan_list : [Test_scan_list]?
    var distance : Double?
    var average_rating : Int?
    var days_availability : String?
    var not_availability_dates : String?
    var allow_booking : Bool?

}
class Test_scan_list : Decodable {
    var laboratory_scan_costing_id : Int?
    var test_scan_id : Int?
    var name : String?
    var amount : Int?
    var is_default : String?
}

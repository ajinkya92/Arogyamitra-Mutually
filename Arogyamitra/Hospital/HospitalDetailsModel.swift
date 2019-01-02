//
//  HospitalDetailsModel.swift
//  Arogyamitra
//
//  Created by Sangram Powar on 25/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import Foundation


class HospitalDetailsModel: Decodable
{
    var code : Int?
    var status : String?
    var message : String?
    var results : [HospitalDetailsResult]?
}


class HospitalDetailsResult : Decodable
{
    let hospital_id : Int?
    let hospital_photo : String?
    let hospital_background_photo : String?
    let hospital_name : String?
    let hospital_services : [Hospital_services]?
    let speciality : String?
    let address : String?
    let latitude : String?
    let longitude : String?
    let city : String?
    let country : String?
    let pincode : String?
    let parent_name : String?
    let phone_no : String?
    let emailid : String?
    let website_url : String?
    let fax : String?
    let status : String?
    let is_24hrs : String?
    let hospital_timings : [Hospital_timings]?
    let doctorlist : [Doctorlist2]?
    let hospital_gallery : [Hospital_gallery]?
    let average_rating : Double?
    let total_reviews : Int?
    let reviews_list : [Reviews_list]?
    let review_exists : Bool?
    let days_availability : String?
    let not_availability_dates : String?

}

class Hospital_gallery: Decodable {
    var photo : String?
}

class Reviews_list : Decodable {
    let review_id : Int?
    let rating : Double?
    let review : String?
    let review_out_of : Int?
    let review_by : String?
    let review_date : String?
}

//MARK: Get Speciality List By Hospital ID

class HospitalDetailsSpecialityModel: Decodable
{
    var code : Int?
    var status : String?
    var message : String?
    var results : [Speciality_list]?
}

class Speciality_list : Decodable {
    let speciality_id : Int?
    let hospital_id : Int?
    let name : String?
    let photo : String?
}


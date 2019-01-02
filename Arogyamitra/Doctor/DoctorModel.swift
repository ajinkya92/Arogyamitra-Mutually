//
//  DoctorModel.swift
//  Arogyamitra
//
//  Created by Nitin Landge on 15/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import Foundation

class DoctorModel: Decodable
{
    var code : Int?
    var status : String?
    var message : String?
    var results : [DoctorResultArray]?
}
class DoctorResultArray: Decodable {
    var description : String?
    var name : String?
    var photo : String?
    var speciality_id : String?
}


//Search Model
class DoctorSearchModel: Decodable
{
    var code : Int?
    var status : String?
    var message : String?
    var results : [DoctorSearchResult]?
}
class DoctorSearchResult: Decodable {
    var id : Int?
    var label : String?
    var category : String?
    var category_prefix : String?
}


//

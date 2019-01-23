//
//  AmbulanceTypeList.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 15/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let ambulanceTypeList = try? newJSONDecoder().decode(AmbulanceTypeList.self, from: jsonData)

import Foundation

struct AmbulanceTypeList: Codable {
    let code: Int
    let status, message: String
    let results: [AmbulanceTypeListResult]
}

struct AmbulanceTypeListResult: Codable {
    let ambulanceTypeID: Int
    let name: String
    let isEmergency: Bool
    let photo: String
    let bookingAmount, ambulanceCount: Int
    
    enum CodingKeys: String, CodingKey {
        case ambulanceTypeID = "ambulance_type_id"
        case name
        case isEmergency = "is_emergency"
        case photo
        case bookingAmount = "booking_amount"
        case ambulanceCount = "ambulance_count"
    }
}


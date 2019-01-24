//
//  EmergencyAmbulanceBooking.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 24/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let emergencyAmbulanceBooking = try? newJSONDecoder().decode(EmergencyAmbulanceBooking.self, from: jsonData)

import Foundation

struct EmergencyAmbulanceBooking: Codable {
    let code: Int
    let status, message: String
    let results: [EmergencyAmbulanceBookingResult]
}

struct EmergencyAmbulanceBookingResult: Codable {
    let requestNo: String
    
    enum CodingKeys: String, CodingKey {
        case requestNo = "request_no"
    }
}

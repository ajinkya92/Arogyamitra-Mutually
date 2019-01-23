//
//  AmbulanceExceptEmergency.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 15/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let ambulanceExceptEmergency = try? newJSONDecoder().decode(AmbulanceExceptEmergency.self, from: jsonData)

import Foundation

struct AmbulanceExceptEmergency: Codable {
    let code: Int
    let status, message: String
    let results: [AmbulanceExceptEmergencyResult]
}

struct AmbulanceExceptEmergencyResult: Codable {
    let ambulanceID: Int
    let ambulancePhoto: String
    let ambulanceType: String
    let bookingAmount: Int
    let ambulanceName, driverName, mobileno, address: String
    let latitude, longitude: String
    let serviceLocation: JSONNull?
    let chargesPerKM, vehicleNo: String
    let outOfStationService: Int
    let bookingStatus, ambulanceIsAvailable, isLoggedIn: String
    
    enum CodingKeys: String, CodingKey {
        case ambulanceID = "ambulance_id"
        case ambulancePhoto = "ambulance_photo"
        case ambulanceType = "ambulance_type"
        case bookingAmount = "booking_amount"
        case ambulanceName = "ambulance_name"
        case driverName = "driver_name"
        case mobileno, address, latitude, longitude
        case serviceLocation = "service_location"
        case chargesPerKM = "charges_per_km"
        case vehicleNo = "vehicle_no"
        case outOfStationService = "out_of_station_service"
        case bookingStatus = "booking_status"
        case ambulanceIsAvailable = "ambulance_is_available"
        case isLoggedIn = "is_logged_in"
    }
}

//
//  AmbulanceLocation.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 19/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let ambulanceLocation = try? newJSONDecoder().decode(AmbulanceLocation.self, from: jsonData)

import Foundation

struct AmbulanceLocation: Codable {
    let code: Int
    let status, message: String
    let results: [AmbulanceLocationResult]
}

struct AmbulanceLocationResult: Codable {
    let id, ambulanceID: Int
    let ambulanceName: String
    let ambulancePhoto: String
    let ambulanceType, driverName, mobileno, address: String
    let latitude, longitude: String
    let serviceLocation: JSONNull?
    let chargesPerKM: String
    let bookingAmount: Int
    let vehicleNo: String
    let outOfStationService: Int
    let bookingStatus, ambulanceIsAvailable, isLoggedIn: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case ambulanceID = "ambulance_id"
        case ambulanceName = "ambulance_name"
        case ambulancePhoto = "ambulance_photo"
        case ambulanceType = "ambulance_type"
        case driverName = "driver_name"
        case mobileno, address, latitude, longitude
        case serviceLocation = "service_location"
        case chargesPerKM = "charges_per_km"
        case bookingAmount = "booking_amount"
        case vehicleNo = "vehicle_no"
        case outOfStationService = "out_of_station_service"
        case bookingStatus = "booking_status"
        case ambulanceIsAvailable = "ambulance_is_available"
        case isLoggedIn = "is_logged_in"
    }
}

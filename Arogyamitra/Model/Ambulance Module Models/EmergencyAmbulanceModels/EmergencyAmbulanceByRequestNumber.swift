//
//  EmergencyAmbulanceByRequestNumber.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 24/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let emergencyAmbulanceByRequestNumber = try? newJSONDecoder().decode(EmergencyAmbulanceByRequestNumber.self, from: jsonData)

import Foundation

struct EmergencyAmbulanceByRequestNumber: Codable {
    let code: Int
    let status, message: String
    let results: [EmergencyAmbulanceByRequestNumberResult]
}

struct EmergencyAmbulanceByRequestNumberResult: Codable {
    let ambulanceID: Int
    let ambulancePhoto: String
    let ambulanceType, ambulanceName, driverName, mobileno: String
    let address, latitude, longitude: String
    let serviceLocation: JSONNull?
    let chargesPerKM, vehicleNo: String
    let outOfStationService: Int
    let bookingStatus: String
    
    enum CodingKeys: String, CodingKey {
        case ambulanceID = "ambulance_id"
        case ambulancePhoto = "ambulance_photo"
        case ambulanceType = "ambulance_type"
        case ambulanceName = "ambulance_name"
        case driverName = "driver_name"
        case mobileno, address, latitude, longitude
        case serviceLocation = "service_location"
        case chargesPerKM = "charges_per_km"
        case vehicleNo = "vehicle_no"
        case outOfStationService = "out_of_station_service"
        case bookingStatus = "booking_status"
    }
}

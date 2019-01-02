//
//  GymnasiumList.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 31/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let gymnasiumList = try? newJSONDecoder().decode(GymnasiumList.self, from: jsonData)

import Foundation

struct GymnasiumList: Codable {
    let code: Int
    let status, message: String
    let results: [GymnasiumListResult]
}

struct GymnasiumListResult: Codable {
    let gymnasiumYogaID, typeID: Int
    let typeName: String
    let photo: String
    let name, address, cityID, cityName: String
    let mobileno, mobilenoMultiple: String
    let discountAllow: Bool
    let discount: Int
    let bankName, bankAccountNo, panCard, ifscCode: String
    let gymnasiumYogaTimings: [GymnasiumYogaTiming]
    let gymnasiumYogaPlans: [GymnasiumYogaPlan]
    let distance: Double
    let averageRating: Int
    let daysAvailability, notAvailabilityDates: String
    let allowBooking: Bool
    let gymnasiumYogaServices: [GymnasiumYogaService]
    
    enum CodingKeys: String, CodingKey {
        case gymnasiumYogaID = "gymnasium_yoga_id"
        case typeID = "type_id"
        case typeName = "type_name"
        case photo, name, address
        case cityID = "city_id"
        case cityName = "city_name"
        case mobileno
        case mobilenoMultiple = "mobileno_multiple"
        case discountAllow = "discount_allow"
        case discount
        case bankName = "bank_name"
        case bankAccountNo = "bank_account_no"
        case panCard = "pan_card"
        case ifscCode = "ifsc_code"
        case gymnasiumYogaTimings = "gymnasium_yoga_timings"
        case gymnasiumYogaPlans = "gymnasium_yoga_plans"
        case distance
        case averageRating = "average_rating"
        case daysAvailability = "days_availability"
        case notAvailabilityDates = "not_availability_dates"
        case allowBooking = "allow_booking"
        case gymnasiumYogaServices = "gymnasium_yoga_services"
    }
}

struct GymnasiumYogaPlan: Codable {
    let gymnasiumYogaPlansID: Int
    let planName: String
    let amount: Int
    
    enum CodingKeys: String, CodingKey {
        case gymnasiumYogaPlansID = "gymnasium_yoga_plans_id"
        case planName = "plan_name"
        case amount
    }
}

struct GymnasiumYogaService: Codable {
    let services: String
}

struct GymnasiumYogaTiming: Codable {
    let gymnasiumYogaTimingID: Int
    let openTime, closeTime: String
    
    enum CodingKeys: String, CodingKey {
        case gymnasiumYogaTimingID = "gymnasium_yoga_timing_id"
        case openTime = "open_time"
        case closeTime = "close_time"
    }
}



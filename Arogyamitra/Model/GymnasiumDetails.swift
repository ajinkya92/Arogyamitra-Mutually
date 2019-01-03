//
//  GymnasiumDetails.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 03/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let gymnasiumDetailsService = try? newJSONDecoder().decode(GymnasiumDetailsService.self, from: jsonData)

import Foundation

struct GymnasiumDetailsService: Codable {
    let code: Int
    let status, message: String
    let results: [GymnasiumDetailsServiceResult]
}

struct GymnasiumDetailsServiceResult: Codable {
    let gymnasiumYogaID, typeID: Int
    let typeName: String
    let photo: String
    let name, address, latitude, longitude: String
    let cityID: Int
    let cityName: JSONNull?
    let mobileno, mobilenoMultiple: String
    let discountAllow: Bool
    let discount: Int
    let bankName, bankAccountNo, panCard, ifscCode: String
    let gymnasiumYogaTimings: [GymnasiumDetailsServiceGymnasiumYogaTiming]
    let gymnasiumYogaPlans: [GymnasiumDetailsServiceGymnasiumYogaPlan]
    let averageRating, totalReviews: Int
    let reviewsList: [ReviewsList]
    let reviewExists: Bool
    let gymnasiumYogaGallery: [GymnasiumDetailsServiceGymnasiumYogaGallery]
    let daysAvailability, notAvailabilityDates: String
    let allowBooking: Bool
    let gymnasiumYogaServices: [GymnasiumDetailsServiceGymnasiumYogaService]
    
    enum CodingKeys: String, CodingKey {
        case gymnasiumYogaID = "gymnasium_yoga_id"
        case typeID = "type_id"
        case typeName = "type_name"
        case photo, name, address, latitude, longitude
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
        case averageRating = "average_rating"
        case totalReviews = "total_reviews"
        case reviewsList = "reviews_list"
        case reviewExists = "review_exists"
        case gymnasiumYogaGallery = "gymnasium_yoga_gallery"
        case daysAvailability = "days_availability"
        case notAvailabilityDates = "not_availability_dates"
        case allowBooking = "allow_booking"
        case gymnasiumYogaServices = "gymnasium_yoga_services"
    }
}

struct GymnasiumDetailsServiceGymnasiumYogaGallery: Codable {
    let photo: String
}

struct GymnasiumDetailsServiceGymnasiumYogaPlan: Codable {
    let gymnasiumYogaPlansID: Int
    let planName: String
    let amount: Int
    
    enum CodingKeys: String, CodingKey {
        case gymnasiumYogaPlansID = "gymnasium_yoga_plans_id"
        case planName = "plan_name"
        case amount
    }
}

struct GymnasiumDetailsServiceGymnasiumYogaService: Codable {
    let services: String
}

struct GymnasiumDetailsServiceGymnasiumYogaTiming: Codable {
    let gymnasiumYogaTimingID: Int
    let openTime, closeTime: String
    
    enum CodingKeys: String, CodingKey {
        case gymnasiumYogaTimingID = "gymnasium_yoga_timing_id"
        case openTime = "open_time"
        case closeTime = "close_time"
    }
}

struct ReviewsList: Codable {
    let reviewID, rating: Int
    let review: String
    let reviewOutOf: Int
    let reviewBy, reviewDate: String
    
    enum CodingKeys: String, CodingKey {
        case reviewID = "review_id"
        case rating, review
        case reviewOutOf = "review_out_of"
        case reviewBy = "review_by"
        case reviewDate = "review_date"
    }
}

// MARK: Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}


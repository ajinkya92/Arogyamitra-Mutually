//
//  TrainerDetails.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 09/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let trainerDetails = try? newJSONDecoder().decode(TrainerDetails.self, from: jsonData)

import Foundation

struct TrainerDetails: Codable {
    let code: Int
    let status, message: String
    let results: [TrainerDetailsResult]
}

struct TrainerDetailsResult: Codable {
    let trainerID: Int
    let photo: String
    let name, address: String
    let cityID: Int
    let cityName: JSONNull?
    let mobileno, mobilenoMultiple, experience, chargesPerVisit: String
    let bankName, bankAccountNo, panCard, ifscCode: String
    let aadharCard: String
    let averageRating: Double
    let totalReviews: Int
    let reviewsList: [TrainerDetailsReviewsList]
    let reviewExists: Bool
    
    enum CodingKeys: String, CodingKey {
        case trainerID = "trainer_id"
        case photo, name, address
        case cityID = "city_id"
        case cityName = "city_name"
        case mobileno
        case mobilenoMultiple = "mobileno_multiple"
        case experience
        case chargesPerVisit = "charges_per_visit"
        case bankName = "bank_name"
        case bankAccountNo = "bank_account_no"
        case panCard = "pan_card"
        case ifscCode = "ifsc_code"
        case aadharCard = "aadhar_card"
        case averageRating = "average_rating"
        case totalReviews = "total_reviews"
        case reviewsList = "reviews_list"
        case reviewExists = "review_exists"
    }
}

struct TrainerDetailsReviewsList: Codable {
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

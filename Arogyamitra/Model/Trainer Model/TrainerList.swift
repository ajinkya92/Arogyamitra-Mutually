//
//  TrainerList.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 08/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let trainerList = try? newJSONDecoder().decode(TrainerList.self, from: jsonData)

import Foundation

struct TrainerList: Codable {
    let code: Int
    let status, message: String
    let results: [TrainerListResult]
}

struct TrainerListResult: Codable {
    let trainerID: Int
    let photo: String
    let name, address: String
    let cityID: Int
    let cityName: JSONNull?
    let mobileno, mobilenoMultiple, experience: String
    let chargesPerVisit: Int
    let bankName, bankAccountNo, panCard, ifscCode: String
    let aadharCard: String
    let distance, averageRating: Int
    
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
        case distance
        case averageRating = "average_rating"
    }
}

//
//  AmbulanceBooking.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 21/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let ambulanceBooking = try? newJSONDecoder().decode(AmbulanceBooking.self, from: jsonData)

import Foundation

struct AmbulanceBooking: Codable {
    let code: Int
    let status, message: String
    let results: [JSONNull]
}


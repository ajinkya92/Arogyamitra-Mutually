//
//  ArogyamNotification.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 09/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let arogyamNotification = try? newJSONDecoder().decode(ArogyamNotification.self, from: jsonData)

import Foundation

struct ArogyamNotification: Codable {
    let code: Int
    let status, message: String
    let results: [ArogyamNotificationResult]
}

struct ArogyamNotificationResult: Codable {
    let notificationID: Int
    let title: String
    let photo: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case notificationID = "notification_id"
        case title, photo, description
    }
}


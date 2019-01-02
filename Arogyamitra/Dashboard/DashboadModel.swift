//
//  DashboadModel.swift
//  Arogyamitra
//
//  Created by Nitin Landge on 15/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import Foundation

class DashboardModel: Decodable
{
    var code : Int?
    var status : String?
    var message : String?
    var results : [DashboardResultArray]?
}
class DashboardResultArray: Decodable {
    var module_id : Int?
    var module_name : String?
    var photo : String?
    var status : Bool?
}













//{
//    "code": 0,
//    "status": "success",
//    "message": "module fetched successfully",
//    "results": [
//    {
//    "module_id": 1,
//    "module_name": "Search Doctor",
//    "photo": "https://arogyamitra.net/doctor/images/module/1231544434611.jpg",
//    "status": true
//    },
//    {
//    "module_id": 2,
//    "module_name": "Search Hospital",
//    "photo": "https://arogyamitra.net/doctor/images/module/Hospital1542093664.jpg",
//    "status": true
//    },
//    {
//    "module_id": 3,
//    "module_name": "Ambulance",
//    "photo": "https://arogyamitra.net/doctor/images/module/ambulance1539196525.jpeg",
//    "status": true
//    },
//    {
//    "module_id": 4,
//    "module_name": "Online Pharmacy",
//    "photo": "https://arogyamitra.net/doctor/images/module/pharmacy_021542094624.jpg",
//    "status": true
//    },
//    {
//    "module_id": 5,
//    "module_name": "Laboratory",
//    "photo": "https://arogyamitra.net/doctor/images/module/Lab1531903279.jpg",
//    "status": true
//    },
//    {
//    "module_id": 6,
//    "module_name": "Physical Fitness",
//    "photo": "https://arogyamitra.net/doctor/images/module/Yoga1542094419.jpg",
//    "status": true
//    },
//    {
//    "module_id": 7,
//    "module_name": "Scan",
//    "photo": "https://arogyamitra.net/doctor/images/module/Sc1542097635.png",
//    "status": true
//    },
//    {
//    "module_id": 8,
//    "module_name": "Arogyam",
//    "photo": "https://arogyamitra.net/doctor/images/module/Health Tips 1542094901.png",
//    "status": true
//    },
//    {
//    "module_id": 9,
//    "module_name": "Gymnasium",
//    "photo": "https://arogyamitra.net/doctor/images/module/Gym-workout1532288229.jpg",
//    "status": true
//    },
//    {
//    "module_id": 10,
//    "module_name": "Yoga Centers",
//    "photo": "https://arogyamitra.net/doctor/images/module/Yoga1532288401.jpg",
//    "status": true
//    },
//    {
//    "module_id": 11,
//    "module_name": "Dietician",
//    "photo": "https://arogyamitra.net/doctor/images/module/D1532288310.jpg",
//    "status": true
//    },
//    {
//    "module_id": 12,
//    "module_name": "Personal Trainer",
//    "photo": "https://arogyamitra.net/doctor/images/module/PT1531904073.jpg",
//    "status": true
//    }
//    ]
//}

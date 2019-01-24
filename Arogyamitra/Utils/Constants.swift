//
//  Constants.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 31/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import Foundation

enum UIUserInterfaceIdiom : Int {
    case unspecified
    case phone // iPhone and iPod touch style UI
    case pad // iPad style UI
}

let USER_REGISTERED_ADDRESS = String()

//MARK: Stay Healthy Module URLS

let GYMNASIUM_LIST_BY_LOCATION_URL = "https://arogyamitra.net/doctor/index.php/Webservice/get_gymnasium_list_by_location"
let GET_GYMNASIUM_DETAILS_URL = "https://arogyamitra.net/doctor/index.php/Webservice/get_gymnasium_details"
let GET_TRAINER_LIST_BY_LOCATION_URL = "https://arogyamitra.net/doctor/index.php/Webservice/get_trainer_list_by_location"
let GET_TRAINER_DETAILS_URL = "https://arogyamitra.net/doctor/index.php/Webservice/get_trainer_details"
let GET_AROGYAM_NOTIFICATION_LIST_URL = "https://arogyamitra.net/doctor/index.php/Webservice/get_notification_list"

//MARK: Ambulance Module URLS

let GET_AMBULANCE_TYPE_LIST = "https://arogyamitra.net/doctor/index.php/Webservice/get_ambulance_type_list"
let GET_AMBULANCE_LIST_EXCEPT_EMERGENCY = "https://arogyamitra.net/doctor/index.php/Webservice/get_ambulance_list_by_ambulance_type"
let GET_AMBULANCE_LOCATION_BY_AMBULANCE_ID_URL = "https://arogyamitra.net/doctor/index.php/Webservice/get_ambulance_location_by_ambulance_id"
let AMBULANCE_BOOKING_URL = "https://arogyamitra.net/doctor/index.php/Webservice/ambulancebooking"


//MARK: EMERGENCY AMBULANCE MODULE URLS

let REQUEST_EMERGENCY_AMBULANCE_BOOKING = "https://arogyamitra.net/doctor/index.php/Webservice/send_request_to_emergency_ambulance"

//
//  MultipleUserLocations.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 16/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

import Foundation
import UIKit
import MapKit

struct MultipleAmbulanceLocations {
    
    let ambulanceName: String
    let driverName: String
    let latitude: Double
    let longitude: Double
    let charges: String
    let ambulanceImageUrl: String
    let ambulanceType: String
    let contactNumber: String
    let vehicleNumber: String
    let outOfServiceValue: Int
    let bookingStatus: String
    let bookingAmount: Int
}

import UIKit
import MapKit

class CustomPointAnnotation: MKPointAnnotation {
    var ambulanceName: String!
    var driverName: String!
    var latitude: Double!
    var longitude: Double!
    var charges: String!
    var ambulanceImageUrl: String!
    var ambulanceType: String!
    var contactNumber: String!
    var vehicleNumber: String!
    var outOfServiceValue: Int!
    var bookingStatus: String!
    var bookingAmount: Int!
    
}

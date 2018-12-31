//
//  CommonMethod.swift
//  Arogyamitra
//
//  Created by Nitin Landge on 15/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import MapKit

var arr_days = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]


//Common Alert View
func showAlertMessage(message : String, title: String)
{
    let alert = UIAlertView()
    alert.title = "Alert"
    alert.message = message
    alert.addButton(withTitle: "OK")
    alert.show()
}

//MARK: Select AvaliableDays
func avaliableDays(days : String) -> String
{
    var str1 = ""
    let stringArray = days.components(separatedBy: CharacterSet.decimalDigits.inverted)
    for item in stringArray {
        if let number = Int(item) {
            let str = arr_days[number - 1]
          str1.addString(str: String(str) + "," )
        }
    }
    return String(str1.dropLast())
    
}
extension String {
    mutating func addString(str: String) {
        self = self + str
    }
    
//    func setKFimage( imageStr : String, image : UIImage)  {
//        image.kf.setImage(with: URL(string:data.photo!
//            .replacingOccurrences(of: " ", with: "%20")), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
//    }
}



//MARK: Phone Call
 func callingNumber(phoneNumber:String) {
    
    if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
        
        let application:UIApplication = UIApplication.shared
        if (application.canOpenURL(phoneCallURL)) {
            application.open(phoneCallURL, options: [:], completionHandler: nil)
        }
    }
}

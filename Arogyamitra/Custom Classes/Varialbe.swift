//
//  Varialbe.swift
//  Arogyamitra
//
//  Created by Nitin Landge on 12/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import Foundation
import UIKit

let LocationStoryboard = UIStoryboard(name: "LocationSearch", bundle: nil)

let containerObj = ContainerViewController()


let otherStatusCodeErrorMessage:String = "The service is temporarily unavailable. \n Please try after some time"
let unauthorizedCodeErrorMessage:String = "Unauthorized \n Please try again"
let noInternetConnectionMessage:String = "No internet data available, please check your data connection and try again"
let nilStatusCodeMessage:String = "Please check your internet \n and try again"
let googleUrl = "www.google.com"



var headerDict = [String: String]()
var parameterDict = Parameters()

func getheaderOfContentType() -> [String: String]
{
    if(!headerDict.isEmpty)
    {
        headerDict.removeAll()
    }
    headerDict["Content-Type"] = "application/json; charset=utf-8"
    return headerDict
}
func getheader() -> [String: String]
{
    if(!headerDict.isEmpty)
    {
        headerDict.removeAll()
    }
    headerDict["Content-Type"] = "application/x-www-form-urlencoded"
    return headerDict
}

func getHospitalParam() -> [String: String]
{
    if(!headerDict.isEmpty)
    {
        headerDict.removeAll()
    }
    headerDict["user_current_latitude"] = "19.0655194"
    headerDict["user_current_longitude"] = "73.00246240000001"

    return headerDict
}

func getDoctorListParam(specialityId : String ) -> [String: String]
{
    if(!headerDict.isEmpty)
    {
        headerDict.removeAll()
    }
    headerDict["user_current_latitude"] = "19.0655194"
    headerDict["user_current_longitude"] = "73.00246240000001"
    headerDict["speciality_id"] = specialityId
    headerDict["patient_id"] = "157"

    return headerDict
}

func getDoctorDeatilsParam(doctorHospitalId : Int ) -> [String: String]
{
    if(!headerDict.isEmpty)
    {
        headerDict.removeAll()
    }
    headerDict["doctor_hospital_id"] = "110"
    headerDict["patient_id"] = "157"
    
    return headerDict
}

func getFavParam(doctorId : Int, patientId : String ) -> [String: String]
{
    if(!headerDict.isEmpty)
    {
        headerDict.removeAll()
    }
    headerDict["doctor_id"] = String(doctorId)
    headerDict["patient_id"] = patientId
    
    return headerDict
}


func getHospitalDeatilsParam(hospitalId : String, patientId : String ) -> [String: String]
{
    if(!headerDict.isEmpty)
    {
        headerDict.removeAll()
    }
    headerDict["hospital_id"] = hospitalId
    headerDict["patient_id"] = patientId
    
    return headerDict
}
func getSpecialityListByHospital(hospitalId : String) -> [String: String]
{
    if(!headerDict.isEmpty)
    {
        headerDict.removeAll()
    }
    headerDict["hospital_id"] = hospitalId
    return headerDict
}


//Laboratory

func geLaboratoryByLoactionParam(type : String ) -> [String: String]
{
    if(!headerDict.isEmpty)
    {
        headerDict.removeAll()
    }
    headerDict["user_current_latitude"] = "19.0655194"
    headerDict["user_current_longitude"] = "73.00246240000001"
    headerDict["type"] = type
    return headerDict
}

func getLabrDeatilsParam(laboratory_scan_id : String ) -> [String: String]
{
    if(!headerDict.isEmpty)
    {
        headerDict.removeAll()
    }
    headerDict["laboratory_scan_id"] = laboratory_scan_id
    headerDict["patient_id"] = "157"
    
    return headerDict
}

//
//  URLManager.swift
//  Arogyamitra
//
//  Created by Nitin Landge on 15/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import Foundation

//https://arogyamitra.net/doctor/index.php/Webservice/get_module_icons
private let baseURL = "https://arogyamitra.net/doctor/index.php/Webservice/"

struct UrlString
{
    func getDashboardURL() -> String
    {
        return baseURL + "get_module_icons"
    }
    
    //Doctor
    func getDoctorURL() -> String
    {
        return baseURL + "get_speciality_list"
    }
    func getDoctorSearchURL() -> String
    {
        return baseURL + "get_search_doctor_speciality_autocompletion"
    }
    
    func getDoctorListBySpecialityURL() -> String
    {
        return baseURL + "get_doctor_list_by_speciality"
    }
    func getDoctorDeatilsBySpecialityURL() -> String
    {
        return baseURL + "get_doctor_details_by_speciality"
    }
    func doctorFavouriteURL() -> String
    {
        return baseURL + "favourite"
    }
    
    //Hospital
    func getHospitalListURL() -> String
    {
        return baseURL + "get_hospital_list_by_location"
    }
    
    func getHospitalSearchURL() -> String
    {
        return baseURL + "get_search_hospital_speciality_autocompletion"
    }
    
    func getHospitalDetailsURL() -> String
    {
        return baseURL + "get_hospital_details"
    }
    
    func get_speciality_list_by_hospital_id_URL() -> String
    {
        return baseURL + "get_speciality_list_by_hospital_id"
    }
    
    

//    Lab
    
    func getLaboratoryScanDetailsByLoactionURL() -> String
    {
        return baseURL + "get_laboratory_scan_list_by_location"
    }
    func getLaboratoryScanDetailsURL() -> String
    {
        return baseURL + "get_laboratory_scan_details"
    }
}


//
//  AmbulanceServices.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 15/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

import Foundation

class AmbulanceServices {
    static let instance = AmbulanceServices()
    
    //MARK: Function Call to get Ambulance Type List
    
    func getAmbulanceTypeList(withUserLatitude latitude: String, withUserLongitude longitude: String, andPatientId patientId: Int, completion: @escaping(_ success: Bool, AmbulanceTypeList?) -> ()) {
        
        let postData = NSMutableData(data: "user_current_latitude=\(latitude)".data(using: String.Encoding.utf8)!)
        postData.append("&user_current_longitude=\(longitude)".data(using: String.Encoding.utf8)!)
        postData.append("&patient_id=\(patientId)".data(using: String.Encoding.utf8)!)
        
        guard let url = URL(string: GET_AMBULANCE_TYPE_LIST) else {return}
        var urlrequest = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 30)
        urlrequest.httpMethod = "POST"
        urlrequest.httpBody = postData as Data
        
        URLSession.shared.dataTask(with: urlrequest) { (data, response, error) in
            
            if error != nil {
                debugPrint(error?.localizedDescription ?? "")
                completion(false, nil)
                return
            }else {
                guard let data = data else {return completion(false, nil)}
                let decoder = JSONDecoder()
                
                do{
                    let returnedAmbulanceListResponse = try decoder.decode(AmbulanceTypeList.self, from: data)
                    completion(true, returnedAmbulanceListResponse)
                }catch{
                    debugPrint(error.localizedDescription)
                    completion(false, nil)
                    return
                }
            }
            
        }.resume()
        
    }
    
    
    //MARK: API FUNCTION TO GET AMBULANCE LIST EXCEPT EXERGENCY
    
    func getAmbulanceListExceptExergency(withAmbulanceTypeId typeId: Int, userCurrentLatitude latitude: String, userCurrentLongitude longitude: String, patientId: Int, completion: @escaping (_ success: Bool, AmbulanceExceptEmergency?) -> ()) {
        
        let postData = NSMutableData(data: "ambulance_type_id=\(typeId)".data(using: String.Encoding.utf8)!)
        postData.append("&user_current_latitude=\(latitude)".data(using: String.Encoding.utf8)!)
        postData.append("&user_current_longitude=\(longitude)".data(using: String.Encoding.utf8)!)
        postData.append("&patient_id=\(patientId)".data(using: String.Encoding.utf8)!)
        
        guard let url = URL(string: GET_AMBULANCE_LIST_EXCEPT_EMERGENCY) else {return}
        var urlrequest = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 30)
        urlrequest.httpMethod = "POST"
        urlrequest.httpBody = postData as Data
        
        URLSession.shared.dataTask(with: urlrequest) { (data, response, error) in
            
            if error != nil {
                debugPrint(error?.localizedDescription ?? "")
                completion(false, nil)
                return
            }else {
                guard let data = data else {return completion(false, nil)}
                let decoder = JSONDecoder()
                
                do{
                    let returnedAmbulanceResponse = try decoder.decode(AmbulanceExceptEmergency.self, from: data)
                    completion(true, returnedAmbulanceResponse)
                }catch{
                    debugPrint(error.localizedDescription)
                    completion(false, nil)
                    return
                }
            }
            
        }.resume()
        
        
    }
    
    //MARK: API FUNCTION TO GET AMBULANCE LOCATION BY AMBULEANCE IDS
    
    func getAmbulanceLocation(withMultipleAmbulanceIdsString idString: String, andPatientId patientId: Int, completion: @escaping(_ success: Bool, AmbulanceLocation?) -> ()) {
        
        let postData = NSMutableData(data: "multiple_ambulance_id=\(idString)".data(using: String.Encoding.utf8)!)
        postData.append("&patient_id=\(patientId)".data(using: String.Encoding.utf8)!)
        
        guard let url = URL(string: GET_AMBULANCE_LOCATION_BY_AMBULANCE_ID_URL) else {return}
        var urlrequest = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 30)
        urlrequest.httpMethod = "POST"
        urlrequest.httpBody = postData as Data
        
        URLSession.shared.dataTask(with: urlrequest) { (data, response, error) in
            
            if error != nil {
                debugPrint(error?.localizedDescription ?? "")
                completion(false, nil)
                return
            }else {
                guard let data = data else {return completion(false, nil)}
                let decoder = JSONDecoder()
                
                do{
                    let returnedAmbulanceLocationResponse = try decoder.decode(AmbulanceLocation.self, from: data)
                    completion(true, returnedAmbulanceLocationResponse)
                }catch{
                    debugPrint(error.localizedDescription)
                    completion(false, nil)
                    return
                }
            }
            
        }.resume()
        
    }
    
    //MARK: API Function To book Normal And Cardiac Ambulance
    
    func bookNormalAndCardiacAmbulance(patientId:Int, ambulanceId:Int, pickupAddress:String, pickupLatitude:String, pickupLongitude:String, paymentMode:Int, paymentGatewayResponse:String, paymentAmount:Int, paymentGateway:Int, couponId:String, couponAmount:Int, walletAmount:Int, completion:@escaping(_ success: Bool, AmbulanceBooking?) -> ()) {
        
        let postData = NSMutableData(data: "patient_id=\(patientId)".data(using: String.Encoding.utf8)!)
        postData.append("&ambulance_id=\(ambulanceId)".data(using: String.Encoding.utf8)!)
        postData.append("&pickup_address=\(pickupAddress)".data(using: String.Encoding.utf8)!)
        postData.append("&pickup_latitude=\(pickupLatitude)".data(using: String.Encoding.utf8)!)
        postData.append("&pickup_longitude=\(pickupLongitude)".data(using: String.Encoding.utf8)!)
        postData.append("&payment_mode=\(paymentMode)".data(using: String.Encoding.utf8)!)
        postData.append("&payment_gateway_response=\(paymentGatewayResponse)".data(using: String.Encoding.utf8)!)
        postData.append("&amount=\(paymentAmount)".data(using: String.Encoding.utf8)!)
        postData.append("&payment_gateway=\(paymentGateway)".data(using: String.Encoding.utf8)!)
        postData.append("&coupon_id=\(couponId)".data(using: String.Encoding.utf8)!)
        postData.append("&coupon_amount=\(couponAmount)".data(using: String.Encoding.utf8)!)
        postData.append("&wallet_amount=\(walletAmount)".data(using: String.Encoding.utf8)!)
        
        guard let url = URL(string: AMBULANCE_BOOKING_URL) else {return}
        var urlrequest = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 30)
        urlrequest.httpMethod = "POST"
        urlrequest.httpBody = postData as Data
        
        URLSession.shared.dataTask(with: urlrequest) { (data, response, error) in
            
            if error != nil {
                debugPrint(error?.localizedDescription ?? "")
                completion(false, nil)
                return
            }else {
                guard let data = data else {return completion(false, nil)}
                let decoder = JSONDecoder()
                
                do{
                    let returnedBookingresponse = try decoder.decode(AmbulanceBooking.self, from: data)
                    completion(true, returnedBookingresponse)
                }catch{
                    debugPrint(error.localizedDescription)
                    completion(false, nil)
                    return
                }
                
            }
            
        }.resume()
        
    }
    
    
    //----------------------------------------------------------------------------------
    
    //MARK: API CALLS FOR EMERGENCY AMBULANCES
    
    
    
    
    
    
    
    
}

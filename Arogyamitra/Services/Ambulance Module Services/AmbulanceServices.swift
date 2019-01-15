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
    
    
    
}

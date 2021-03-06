//
//  GymnasiumServices.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 31/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import Foundation

class GymnasiumServices {
    static let instance = GymnasiumServices()
    
    //MARK: API for getting Gym list by location.
    
    func getGymnasiumOrYogaListByLocation(latitude: String, longitude: String, completion: @escaping (_ success: Bool, GymnasiumOrYogaList?) -> ()) {
        
        let postData = NSMutableData(data: "user_current_latitude=\(latitude)".data(using: String.Encoding.utf8)!)
        postData.append("&user_current_longitude=\(longitude)".data(using: String.Encoding.utf8)!)
        
        guard let url = URL(string: GYMNASIUM_LIST_BY_LOCATION_URL) else {return}
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
                    let returnedGymnasiumList = try decoder.decode(GymnasiumOrYogaList.self, from: data)
                    completion(true, returnedGymnasiumList)
                    
                }catch{
                    debugPrint(error.localizedDescription)
                    completion(false, nil)
                    return
                }
            }
            
        }.resume()
        
        
    }
    
    //MARK: API SERVICE FOR GETIING GYMNAISUM DETAILS.
    
    func getGymnasiumOrYogaDetails(withGymnasiumOrYogaId gymnasiumIdOrYoga: Int, andPatientId patientId: Int, completion: @escaping(_ success: Bool, GymnasiumOrYogaDetailsService?) -> ()) {
        let postData = NSMutableData(data: "gymnasium_id=\(gymnasiumIdOrYoga)".data(using: String.Encoding.utf8)!)
        postData.append("&patient_id=\(patientId)".data(using: String.Encoding.utf8)!)
        
        guard let url = URL(string: GET_GYMNASIUM_DETAILS_URL) else {return}
        
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
                    let returnedGymnasiumDetailsData = try decoder.decode(GymnasiumOrYogaDetailsService.self, from: data)
                    completion(true, returnedGymnasiumDetailsData)
                }catch{
                    debugPrint(error.localizedDescription)
                    completion(false, nil)
                    return
                }
            }
            
        }.resume()
        
    }
    
    
}

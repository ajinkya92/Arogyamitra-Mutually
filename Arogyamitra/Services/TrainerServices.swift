//
//  TrainerServices.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 08/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

import Foundation

class TrainerServices {
    static let instance = TrainerServices()
    
    //Mark: API to get Trainer List by Location
    
    func getTrainerListByLocation(withLatitude latitude: String, andLongitude longitude: String, completion: @escaping(_ success: Bool, TrainerList?) -> ()) {
        
        let postData = NSMutableData(data: "user_current_latitude=\(latitude)".data(using: String.Encoding.utf8)!)
        postData.append("&user_current_longitude=\(longitude)".data(using: String.Encoding.utf8)!)
        
        guard let url = URL(string: GET_TRAINER_LIST_BY_LOCATION_URL) else {return}
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
                    let returnedTrainerListData = try decoder.decode(TrainerList.self, from: data)
                    completion(true, returnedTrainerListData)
                    
                }catch{
                    debugPrint(error.localizedDescription)
                    completion(false, nil)
                    return
                }
            }
            
        }.resume()
        
    }
    
    //MARK: API CALL For Trainer Details
    
    func getTrainerDetails(withTrainerId: Int, andPatientId: Int, completion: @escaping(_ success: Bool, TrainerDetails?) -> ()) {
        
        let postData = NSMutableData(data: "trainer_id=\(withTrainerId)".data(using: String.Encoding.utf8)!)
        postData.append("&patient_id=\(andPatientId)".data(using: String.Encoding.utf8)!)
        
        guard let url = URL(string: GET_TRAINER_DETAILS_URL) else {return}
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
                    let returnedTrainerDetailsData = try decoder.decode(TrainerDetails.self, from: data)
                    completion(true, returnedTrainerDetailsData)
                    
                }catch{
                    debugPrint(error.localizedDescription)
                    completion(false, nil)
                    return
                }
            }
            
            }.resume()
        
    }
    
}

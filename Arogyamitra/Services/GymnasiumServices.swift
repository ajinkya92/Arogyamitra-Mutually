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
    
    func getGymnasiumListByLocation(latitude: String, longitude: String, completion: @escaping (_ success: Bool, GymnasiumList?) -> ()) {
        
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
                    let returnedGymnasiumList = try decoder.decode(GymnasiumList.self, from: data)
                    completion(true, returnedGymnasiumList)
                    
                }catch{
                    debugPrint(error.localizedDescription)
                    completion(false, nil)
                    return
                }
            }
            
        }.resume()
        
        
    }
    
    
    
    
}

//
//  ArogyamServices.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 09/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

import Foundation

class ArogyamServices {
    static let instance = ArogyamServices()
    
    //MARK: API TO GET AROGYAM SERVICE DATA
    
    func getArogyamNotificationList(completion: @escaping(_ success: Bool, ArogyamNotification?) -> ()) {
        
        guard let url = URL(string: GET_AROGYAM_NOTIFICATION_LIST_URL) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                debugPrint(error?.localizedDescription ?? "")
                completion(false, nil)
                return
            }else {
                guard let data = data else {return completion(false, nil)}
                let decoder = JSONDecoder()
                
                do{
                    let returnedNotificationListData = try decoder.decode(ArogyamNotification.self, from: data)
                    completion(true, returnedNotificationListData)
                }catch{
                    debugPrint(error.localizedDescription)
                    completion(false, nil)
                    return
                }
            }
            
        }.resume()
        
    }
}

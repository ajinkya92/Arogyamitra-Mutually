//
//  NotificationVC.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 09/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

import UIKit

class ArogyamVC: UIViewController {
    
    @IBOutlet weak var arogyamTableView: UITableView!
    
    //Collection Variables
    var arogyamNotificationListArray = [ArogyamNotificationResult]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getArogyamNotificationList()
        arogyamTableView.delegate = self
        arogyamTableView.dataSource = self
        
    }
    
}

//MARK: Arogyam Tableview Implementation

extension ArogyamVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arogyamNotificationListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = arogyamTableView.dequeueReusableCell(withIdentifier: "ArogyamTblCell") as? ArogyamTblCell else {return UITableViewCell()}
        cell.configureArogyamTblCell(arogyamResult: arogyamNotificationListArray[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}


//MARK: API CALL FOR NOTIFICATION LIST
extension ArogyamVC {
    
    func getArogyamNotificationList() {
        ArogyamServices.instance.getArogyamNotificationList { (success, returnedNotificationListData) in
            
            if let returnedNotificationListData = returnedNotificationListData {
                self.arogyamNotificationListArray = returnedNotificationListData.results
            }
            
            DispatchQueue.main.async {
                self.arogyamTableView.reloadData()
            }
        }
        
    }
}

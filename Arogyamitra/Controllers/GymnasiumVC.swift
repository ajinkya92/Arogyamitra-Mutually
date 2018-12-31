//
//  GymnasiumVC.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 31/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import UIKit

class GymnasiumVC: UIViewController {
    
    //OUTLETS:
    @IBOutlet weak var tableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGymnasiumList()
        tableview.delegate = self
        tableview.dataSource = self
        
    }
    
    //Storage Variables
    var gymnasiumListArray = [GymnasiumListResult]()


}

//MARK: TableView Implementation

extension GymnasiumVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gymnasiumListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "GymnasiumDetailsTableCell") as? GymnasiumDetailsTableCell else {return UITableViewCell()}
        
        cell.configureGymnasiumCell(gymnasiumListResult: gymnasiumListArray[indexPath.row])
        
        return cell
    }
    
}


// MARK: API CALLS WRITTEN HERE

extension GymnasiumVC {

    func loadGymnasiumList() {
        
        GymnasiumServices.instance.getGymnasiumListByLocation(latitude: "19.077064399", longitude: "72.9989925") { (success, returnedGymnasiumList) in
            
            if let returnedGymnasiumList = returnedGymnasiumList {
                self.gymnasiumListArray = returnedGymnasiumList.results
            }
            
            //print("Returned Gymnasium List Array: \(self.gymnasiumListArray)")
            
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }
}

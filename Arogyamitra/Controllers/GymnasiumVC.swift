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
    
    //Animation Outlets:
    @IBOutlet weak var servicePopupViewBottonConstraint: NSLayoutConstraint!
    @IBOutlet weak var serviceCountLbl: UILabel!
    @IBOutlet weak var gymnasiumNameDisplayLbl: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGymnasiumList()
        tableview.delegate = self
        tableview.dataSource = self
        
    }
    
    //Storage Variables
    var gymnasiumListArray = [GymnasiumListResult]()
    
    
    //MARK: Actions for Service Popup View
    
    @IBAction func servicePopupCancelButtonTapped() {
        self.servicePopupViewBottonConstraint.constant = -1000
        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }


}

//MARK: TableView Implementation

extension GymnasiumVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gymnasiumListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "GymnasiumDetailsTableCell") as? GymnasiumDetailsTableCell else {return UITableViewCell()}
        
        cell.configureGymnasiumCell(gymnasiumListResult: gymnasiumListArray[indexPath.row])
        
        cell.delegate = self
        cell.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
}

// MARK: Gymnasium Tableview Cell Delegate Functions written here...
extension GymnasiumVC: GymnasiumDetailsTableCellDelegate {
    
    func didTapServiceLabel(_ tag: Int) {
        self.servicePopupViewBottonConstraint.constant = 0
        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        print(tag)
        self.gymnasiumNameDisplayLbl.text = self.gymnasiumListArray[tag].name
        self.serviceCountLbl.text = "Services (\(gymnasiumListArray[tag].gymnasiumYogaServices.count))"
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

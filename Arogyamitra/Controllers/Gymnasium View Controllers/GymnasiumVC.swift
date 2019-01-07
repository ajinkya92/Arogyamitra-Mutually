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
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var searchTextFieldOuterView: UIView!
    
    //Animation Outlets:
    
    @IBOutlet weak var servicePopupView: UIView!
    @IBOutlet weak var servicePopupViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var servicePopupViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var serviceCountLbl: UILabel!
    @IBOutlet weak var gymnasiumNameDisplayLbl: UILabel!
    
    //Service POPUP View Collection VIEW OUTLET
    @IBOutlet weak var servicePopupCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGymnasiumList()
        tableview.delegate = self
        tableview.dataSource = self
        servicePopupCollectionView.delegate = self
        servicePopupCollectionView.dataSource = self
        searchTextField.delegate = self
        
        
        searchTextField.layer.borderColor = UIColor.lightGray.cgColor
        searchTextField.layer.borderWidth = 1
        searchTextFieldOuterView.layer.borderColor = UIColor.lightGray.cgColor
        searchTextFieldOuterView.layer.borderWidth = 1
        searchTextField.layer.sublayerTransform = CATransform3DMakeTranslation(12, 0, 0)
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    //Storage Variables
    var gymnasiumListArray = [GymnasiumListResult]()
    var gymnasiumServiceListArray = [GymnasiumYogaService]()
    
    //Search and Cell variables
    var cellName: String?
    var isSearching = false
    var searchingArray = [GymnasiumListResult]()
    
    //Variables To Pass
    var gymnasiumIdToPass = Int()

    
    //MARK: Actions for Service Popup View
    
    @IBAction func servicePopupCancelButtonTapped() {
        self.servicePopupViewBottomConstraint.constant = 1000
        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }


}

//MARK: TableView Implementation

extension GymnasiumVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return searchingArray.count
        }else {
          return gymnasiumListArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isSearching {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "GymnasiumSearchTblCell") as? GymnasiumSearchTblCell else {return UITableViewCell()}
            
            cell.configureGymnasiumSearchCell(gymnasiumListResult: searchingArray[indexPath.row])
            cellName = "gymnasiumSearchCell"
            return cell
        }else {
            guard let cell = tableview.dequeueReusableCell(withIdentifier: "GymnasiumListTableCell") as? GymnasiumListTableCell else {return UITableViewCell()}
            
            cell.configureGymnasiumCell(gymnasiumListResult: gymnasiumListArray[indexPath.row])
            
            cell.delegate = self
            cell.tag = indexPath.row
            cellName = "gymnasiumListCell"
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if isSearching {
            return UITableView.automaticDimension
        }else {
           return 250
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if cellName == "gymnasiumListCell" {
            gymnasiumIdToPass = gymnasiumListArray[indexPath.row].gymnasiumYogaID
        }else {
            gymnasiumIdToPass = searchingArray[indexPath.row].gymnasiumYogaID
        }
        
        guard let gymnasiumDetailsVc = storyboard?.instantiateViewController(withIdentifier: "GymnasiumDetailsVC") as? GymnasiumDetailsVC else {return}
        gymnasiumDetailsVc.gymnasiumId = self.gymnasiumIdToPass
        self.navigationController?.pushViewController(gymnasiumDetailsVc, animated: true)
        
    }
    
}

// MARK: Gymnasium Tableview Cell Delegate Functions written here...
extension GymnasiumVC: GymnasiumListTableCellDelegate {
    
    func didTapVisitButton(_ tag: Int) {
        
        if cellName == "gymnasiumListCell" {
            gymnasiumIdToPass = gymnasiumListArray[tag].gymnasiumYogaID
        }else {
            gymnasiumIdToPass = searchingArray[tag].gymnasiumYogaID
        }
        
        guard let gymnasiumDetailsVc = storyboard?.instantiateViewController(withIdentifier: "GymnasiumDetailsVC") as? GymnasiumDetailsVC else {return}
        gymnasiumDetailsVc.gymnasiumId = self.gymnasiumIdToPass
        self.navigationController?.pushViewController(gymnasiumDetailsVc, animated: true)
        
    }
    
    
    func didTapServiceLabel(_ tag: Int) {
        //print(tag)
        self.servicePopupCollectionView.reloadData()
        self.gymnasiumNameDisplayLbl.text = self.gymnasiumListArray[tag].name
        self.serviceCountLbl.text = "Services (\(gymnasiumListArray[tag].gymnasiumYogaServices.count))"
        gymnasiumServiceListArray = gymnasiumListArray[tag].gymnasiumYogaServices
        
        self.servicePopupViewBottomConstraint.constant = 0
        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        
    }
    
}

// MARK: SERVICE POPUP COLLECTION VIEW IMPLEMENTATION

extension GymnasiumVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gymnasiumServiceListArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = servicePopupCollectionView.dequeueReusableCell(withReuseIdentifier: "GymnasiumServicePopupCollectionCell", for: indexPath) as? GymnasiumServicePopupCollectionCell else {return UICollectionViewCell()}
        
        cell.configureServicesCell(gymnasiumServices: gymnasiumServiceListArray[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (servicePopupView.frame.width - 10)/2
        let layout = servicePopupCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: 60)
        return layout.itemSize
    }
    
    
}

//MARK: GYMNASIUM SEARCH FUNCTIONALITY IMPLEMENTATION - TEXTFIELD SEARCH BAR

extension GymnasiumVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        searchTextField.resignFirstResponder()
        searchTextField.text = ""
        tableview.reloadData()
        return true
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if searchTextField.text != "" {
            
            isSearching = true
            searchingArray = gymnasiumListArray.filter({$0.name.lowercased().prefix((textField.text?.count)!) == textField.text!.lowercased()})
            
            tableview.reloadData()
        } else {
            isSearching = false
            tableview.reloadData()
            searchTextField.resignFirstResponder()
        }
        
        
        
    }
    
}

// MARK: API CALLS WRITTEN HERE

extension GymnasiumVC {

    func loadGymnasiumList() {
        
        self.view.makeToastActivity(.center)
        
        GymnasiumServices.instance.getGymnasiumListByLocation(latitude: "19.077064399", longitude: "72.9989925") { (success, returnedGymnasiumList) in
            
            if let returnedGymnasiumList = returnedGymnasiumList {
                
                for filteringGymnasiums in returnedGymnasiumList.results {
                    
                    if filteringGymnasiums.typeID == 1 {
                        self.gymnasiumListArray.append(filteringGymnasiums)
                    }
                }
                
            }
            
            //print("Returned Gymnasium List Array: \(self.gymnasiumListArray)")
            
            DispatchQueue.main.async {
                self.tableview.reloadData()
                self.servicePopupCollectionView.reloadData()
                self.view.hideToastActivity()
                
            }
        }
    }
}

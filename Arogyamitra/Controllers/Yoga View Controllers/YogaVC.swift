//
//  YogaVC.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 07/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

import UIKit

class YogaVC: UIViewController {
    
    //Outlets
    
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var searchTextFieldOuterView: UIView!
    @IBOutlet weak var yogaListTableView: UITableView!
    
    //Search and Cell variables
    var cellName: String?
    var isSearching = false
    var searchingArray = [GymnasiumOrYogaListResult]()
    
    //Animation Outlets:
    
    @IBOutlet weak var yogaCentreservicePopupView: UIView!
    @IBOutlet weak var yogaCentreservicePopupViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var yogaCentreservicePopupViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var yogaCentreserviceCountLbl: UILabel!
    @IBOutlet weak var yogaCentreNameDisplayLbl: UILabel!
    
    //Service POPUP View Collection VIEW OUTLET
    @IBOutlet weak var yogaCentreServicePopupCollectionView: UICollectionView!
    
    //Variables To Pass
    var yogaCentreIdToPass = Int()
    var yogaCentreNameToPass = String()
    
    //Storage Variables
    var yogaListArray = [GymnasiumOrYogaListResult]()
    var yogaCentreListServiceListArray = [GymnasiumYogaService]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadYogaList()
        searchTextField.delegate = self
        yogaListTableView.delegate = self
        yogaListTableView.dataSource = self
        yogaCentreServicePopupCollectionView.delegate = self
        yogaCentreServicePopupCollectionView.dataSource = self
        
        searchTextField.layer.borderColor = UIColor.lightGray.cgColor
        searchTextField.layer.borderWidth = 1
        searchTextFieldOuterView.layer.borderColor = UIColor.lightGray.cgColor
        searchTextFieldOuterView.layer.borderWidth = 1
        searchTextField.layer.sublayerTransform = CATransform3DMakeTranslation(12, 0, 0)
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    //MARK: Actions for Service Popup View
    
    @IBAction func yogaCentreServicePopupCancelButtonTapped() {
        self.yogaCentreservicePopupViewBottomConstraint.constant = 1000
        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }


}

//MARK: TableView Implementation

extension YogaVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return searchingArray.count
        }else {
            return yogaListArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isSearching {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "YogaCentreSearchTblCell") as? YogaCentreSearchTblCell else {return UITableViewCell()}
            
            cell.configureYogaCentreSearchCell(yogaCentreListResult: searchingArray[indexPath.row])
            cellName = "yogaCentreSearchCell"
            return cell
        }else {
            guard let cell = yogaListTableView.dequeueReusableCell(withIdentifier: "YogaListTblCell") as? YogaListTblCell else {return UITableViewCell()}
            
            cell.configureYogaCentreCell(yogaCentreListResult: yogaListArray[indexPath.row])
            
            cell.delegate = self
            cell.tag = indexPath.row
            cellName = "yogaCentreListCell"
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

        if cellName == "yogaCentreListCell" {
            yogaCentreIdToPass = yogaListArray[indexPath.row].gymnasiumYogaID
            yogaCentreNameToPass = yogaListArray[indexPath.row].name
            
        }else {
            yogaCentreIdToPass = searchingArray[indexPath.row].gymnasiumYogaID
            yogaCentreNameToPass = searchingArray[indexPath.row].name
        }

        guard let yogaCentreDetailsVc = storyboard?.instantiateViewController(withIdentifier: "YogaCentreDetailsVC") as? YogaCentreDetailsVC else {return}
        yogaCentreDetailsVc.yogaCentreId = self.yogaCentreIdToPass
        yogaCentreDetailsVc.title = self.yogaCentreNameToPass
        self.navigationController?.pushViewController(yogaCentreDetailsVc, animated: true)

    }
    
}

// MARK: Gymnasium Tableview Cell Delegate Functions written here...
extension YogaVC: YogaListTblCelllDelegate {
    
    func didTapVisitButton(_ tag: Int) {
        if cellName == "yogaCentreListCell" {
            yogaCentreIdToPass = yogaListArray[tag].gymnasiumYogaID
            yogaCentreNameToPass = yogaListArray[tag].name
            
        }else {
            yogaCentreIdToPass = searchingArray[tag].gymnasiumYogaID
            yogaCentreNameToPass = searchingArray[tag].name
        }
        
        guard let yogaCentreDetailsVc = storyboard?.instantiateViewController(withIdentifier: "YogaCentreDetailsVC") as? YogaCentreDetailsVC else {return}
        yogaCentreDetailsVc.yogaCentreId = self.yogaCentreIdToPass
        yogaCentreDetailsVc.title = self.yogaCentreNameToPass
        self.navigationController?.pushViewController(yogaCentreDetailsVc, animated: true)
        
    }
    
    
    func didTapServiceLabel(_ tag: Int) {
        //print(tag)
        self.yogaCentreServicePopupCollectionView.reloadData()
        self.yogaCentreNameDisplayLbl.text = self.yogaListArray[tag].name
        self.yogaCentreserviceCountLbl.text = "Services (\(yogaListArray[tag].gymnasiumYogaServices.count))"
        yogaCentreListServiceListArray = yogaListArray[tag].gymnasiumYogaServices
        
        self.yogaCentreservicePopupViewBottomConstraint.constant = 0
        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        
    }
    
}

// MARK: SERVICE POPUP COLLECTION VIEW IMPLEMENTATION

extension YogaVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return yogaCentreListServiceListArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = yogaCentreServicePopupCollectionView.dequeueReusableCell(withReuseIdentifier: "YogaCentreServicePopupCollectionCell", for: indexPath) as? YogaCentreServicePopupCollectionCell else {return UICollectionViewCell()}
        
        cell.configureServicesCell(yogaCentreServices: yogaCentreListServiceListArray[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (yogaCentreservicePopupView.frame.width - 10)/2
        let layout = yogaCentreServicePopupCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: 60)
        return layout.itemSize
    }
    
    
}

//MARK: GYMNASIUM SEARCH FUNCTIONALITY IMPLEMENTATION - TEXTFIELD SEARCH BAR

extension YogaVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        searchTextField.resignFirstResponder()
        searchTextField.text = ""
        yogaListTableView.reloadData()
        return true
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if searchTextField.text != "" {
            
            isSearching = true
            searchingArray = yogaListArray.filter({$0.name.lowercased().prefix((textField.text?.count)!) == textField.text!.lowercased()})
            
            yogaListTableView.reloadData()
        } else {
            isSearching = false
            yogaListTableView.reloadData()
            searchTextField.resignFirstResponder()
        }
        
        
        
    }
    
}



// MARK: API CALLS WRITTEN HERE

extension YogaVC {
    
    func loadYogaList() {
        
        self.view.makeToastActivity(.center)
        
        GymnasiumServices.instance.getGymnasiumOrYogaListByLocation(latitude: "19.077064399", longitude: "72.9989925") { (success, returnedGymnasiumList) in
            
            if let returnedGymnasiumList = returnedGymnasiumList {
                
                for filteringYogaCenters in returnedGymnasiumList.results {
                    
                    if filteringYogaCenters.typeID == 2 {
                        self.yogaListArray.append(filteringYogaCenters)
                    }
                }
                
            }
            
            //print("Returned Yoga List Array: \(self.yogaListArray)")
            
            DispatchQueue.main.async {
                self.yogaListTableView.reloadData()
                self.yogaCentreServicePopupCollectionView.reloadData()
                self.view.hideToastActivity()
                
            }
        }
    }
}

//
//  TrainerVC.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 08/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

import UIKit

class TrainerVC: UIViewController {
    
    //OUTLETS
    @IBOutlet weak var trainerListTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet private weak var searchTextFieldOuterView: UIView!
    
    //Flag Variables
    var isSearching = false
    var cellName = String()
    
    //Storage Variables
    var trainersListArray = [TrainerListResult]()
    var searchingArray =  [TrainerListResult]()
    
    //Variable
    var trainerIdToPass = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTrainersList()
        trainerListTableView.delegate = self
        trainerListTableView.dataSource = self
        searchTextField.delegate = self
        
        searchTextField.layer.borderColor = UIColor.lightGray.cgColor
        searchTextField.layer.borderWidth = 1
        searchTextFieldOuterView.layer.borderColor = UIColor.lightGray.cgColor
        searchTextFieldOuterView.layer.borderWidth = 1
        searchTextField.layer.sublayerTransform = CATransform3DMakeTranslation(12, 0, 0)
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    
}

// MARK: TableView Implementation
extension TrainerVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return searchingArray.count
        }else {
            return trainersListArray.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isSearching {
            guard let cell = trainerListTableView.dequeueReusableCell(withIdentifier: "SearchTrainerTblCell") as? SearchTrainerTblCell else {return UITableViewCell()}
            cell.configureSearchTrainerCell(trainerDetails: searchingArray[indexPath.row])
            cellName = "trainerSearchCell"
            return cell
        }else {
            
            guard let cell = trainerListTableView.dequeueReusableCell(withIdentifier: "TrainerListTblCell") as? TrainerListTblCell else {return UITableViewCell()}
            cell.configureTrainerListCell(trainerListData: trainersListArray[indexPath.row])
            cell.delegate = self
            cell.tag = indexPath.row
            cellName = "trainerListCell"
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isSearching {
            return UITableView.automaticDimension
        }else {
            return 200
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if cellName == "trainerListCell" {
            trainerIdToPass = trainersListArray[indexPath.row].trainerID
        }else {
            trainerIdToPass = searchingArray[indexPath.row].trainerID
        }
        
        guard let trainerDetailsVc = storyboard?.instantiateViewController(withIdentifier: "TrainerDetailsVC") as? TrainerDetailsVC else {return}
        trainerDetailsVc.trainerId = trainerIdToPass
        self.navigationController?.pushViewController(trainerDetailsVc, animated: true)
        
    }
    
}

// MARK: Trainer List Cell Delegate Methods Implementation
extension TrainerVC: TrainerListTblCellDelegate {
    func didtapVisitButton(tag: Int) {
        //print(tag)
        
        if cellName == "trainerListCell" {
            trainerIdToPass = trainersListArray[tag].trainerID
        }else {
            trainerIdToPass = searchingArray[tag].trainerID
        }
        
        guard let trainerDetailsVc = storyboard?.instantiateViewController(withIdentifier: "TrainerDetailsVC") as? TrainerDetailsVC else {return}
        trainerDetailsVc.trainerId = trainerIdToPass
        self.navigationController?.pushViewController(trainerDetailsVc, animated: true)
        
    }
    
}

//MARK: TRAINER SEARCH FUNCTIONALITY IMPLEMENTATION - TEXTFIELD SEARCH BAR

extension TrainerVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        searchTextField.resignFirstResponder()
        searchTextField.text = ""
        trainerListTableView.reloadData()
        return true
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if searchTextField.text != "" {
            
            isSearching = true
            searchingArray = trainersListArray.filter({$0.name.lowercased().prefix((textField.text?.count)!) == textField.text!.lowercased()})
            
            trainerListTableView.reloadData()
        } else {
            isSearching = false
            trainerListTableView.reloadData()
            searchTextField.resignFirstResponder()
        }
        
        
        
    }
    
}


//MARK: API Call to get Trainers List By Location
extension TrainerVC {
    
    func getTrainersList() {
        
        self.view.makeToastActivity(.center)
        TrainerServices.instance.getTrainerListByLocation(withLatitude: "\(19.077064399)", andLongitude: "\(72.9989925)") { (success, returnedTrainersListData) in
            
            if let returnedTrainersList = returnedTrainersListData {
                self.trainersListArray = returnedTrainersList.results
            }
            //print("Trainers List Array: \(self.trainersListArray)")
            
            DispatchQueue.main.async {
                self.trainerListTableView.reloadData()
                self.view.hideToastActivity()
            }
            
        }
    }
    
}

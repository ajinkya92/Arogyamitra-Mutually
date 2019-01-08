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
    
    //Storage Variables
    var trainersListArray = [TrainerListResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTrainersList()
        trainerListTableView.delegate = self
        trainerListTableView.dataSource = self
        
    }
    
    
}

// MARK: TableView Implementation
extension TrainerVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trainersListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = trainerListTableView.dequeueReusableCell(withIdentifier: "TrainerListTblCell") as? TrainerListTblCell else {return UITableViewCell()}
        cell.configureTrainerListCell(trainerListData: trainersListArray[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}

//MARK: API Call to get Trainers List By Location
extension TrainerVC {
    
    func getTrainersList() {
        
        TrainerServices.instance.getTrainerListByLocation(withLatitude: "\(19.077064399)", andLongitude: "\(72.9989925)") { (success, returnedTrainersListData) in
            
            if let returnedTrainersList = returnedTrainersListData {
                self.trainersListArray = returnedTrainersList.results
            }
            //print("Trainers List Array: \(self.trainersListArray)")
            
            DispatchQueue.main.async {
                self.trainerListTableView.reloadData()
            }
            
        }
    }
    
}

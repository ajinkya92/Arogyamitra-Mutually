//
//  LaboratoryViewController.swift
//  Arogyamitra
//
//  Created by Sangram Powar on 27/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import UIKit

class LaboratoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var arr_laboratoryList = [LaboratoryResult]()

    override func viewDidLoad() {
        super.viewDidLoad()
        LabAPICall()
    }
    

}

extension LaboratoryViewController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arr_laboratoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! LaboratoryTableViewCell
        if arr_laboratoryList.count > 0{
            let data = arr_laboratoryList[indexPath.row]
            cell.setLabdata(data: data)
        }
        
        tableView.separatorColor = UIColor.clear
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LaboratoryDetailsViewController") as! LaboratoryDetailsViewController
        let data = arr_laboratoryList[indexPath.row]
        viewController.labScanId = data.laboratory_scan_id!
        
        self.navigationController?.pushViewController(viewController, animated: true)    }
    
}

extension LaboratoryViewController{
    func LabAPICall()
    {
        self.view.makeToastActivity(.center)
        let url = UrlString().getLaboratoryScanDetailsByLoactionURL()
        WebserviceHelper.sharedInstance.getData(URL: url, parameterDict: geLaboratoryByLoactionParam(type: "1"), methodType: .post, headerDict: getheader(), Encoding: URLEncoding.default, successBlock:{
            (responseData) in
            do
            {
                let labData = try JSONDecoder().decode(LaboratoryModel.self, from: responseData!)
                
                if labData.results != nil
                {
                    self.arr_laboratoryList = labData.results!
                    self.tableView.reloadData()
                }
            }
            catch
            {
                print(error)
            }
            
            self.view.hideToastActivity()
            
            
        }, failureMessage: {
            (failureMessage) in
            // Show Failure Message
            self.view.hideToastActivity()
            
            //            self.view?.makeToast(failureMessage, duration: "toastTimeDuration", position: .center)
            
        })
}
}

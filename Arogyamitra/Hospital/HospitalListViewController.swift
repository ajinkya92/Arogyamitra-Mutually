//
//  HospitalListViewController.swift
//  Arogyamitra
//
//  Created by Nitin Landge on 10/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import UIKit

class HospitalListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var arr_hospitalList = [HospitalResult]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        hospitalAPICall()
    }
    
    
    @IBAction func btn_moreServicesPressed(_ sender: Any) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ServicesViewController") as! ServicesViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
}
extension HospitalListViewController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arr_hospitalList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HospitalListTableViewCell
        let data = arr_hospitalList[indexPath.row]
        cell.setHospitalData(data: data)
        tableView.separatorColor = UIColor.clear
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let hospitalDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "HospitalDetailsViewController") as! HospitalDetailsViewController
        let data = arr_hospitalList[indexPath.row]
        hospitalDetailsViewController.hospitalID = data.hospital_id!

        self.navigationController?.pushViewController(hospitalDetailsViewController, animated: true)

    }
}

extension HospitalListViewController{
    
    func hospitalAPICall()
    {
        self.view.makeToastActivity(.center)
        let url = UrlString().getHospitalListURL()
        
        
        WebserviceHelper.sharedInstance.getData(URL: url, parameterDict: getHospitalParam(), methodType: .post, headerDict: getheader(), Encoding: URLEncoding.default, successBlock:{
            (responseData) in
            do
            {
                let hospitalList = try JSONDecoder().decode(HospitalListModel.self, from: responseData!)
                
                if hospitalList.results != nil
                {
                    self.arr_hospitalList = hospitalList.results!
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

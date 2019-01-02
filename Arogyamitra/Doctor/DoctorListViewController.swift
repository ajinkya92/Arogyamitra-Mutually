//
//  DoctorListViewController.swift
//  Arogyamitra
//
//  Created by Nitin Landge on 09/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import UIKit

class DoctorListViewController: UIViewController {
    
    var arr_doctorList = [DoctorResultList]()
    var specialityId = ""
    var tapID = IndexPath()


    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        doctorListAPICall()
    }
    
    func displayTextMessage(msg : String) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 21))
        label.center = CGPoint(x: 160, y: 285)
        label.textAlignment = .center
        label.text = msg
        self.view.addSubview(label)
        label.center = self.view.center
        label.center.x = self.view.center.x
        label.center.y = self.view.center.y
        self.view.addSubview(label)
    }
    
    @IBAction func btn_likePressed(_ sender: Any) {
        let buttonPosition:CGPoint = (sender as AnyObject).convert(CGPoint.zero, to: tableView)
        tapID = tableView.indexPathForRow(at: buttonPosition)!
        
        let data = self.arr_doctorList[self.tapID.row]
        doctorLikeAPICall(doctorId: data.doctor_id!)
    }
}

extension DoctorListViewController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arr_doctorList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DoctorListTableViewCell
        if arr_doctorList.count > 0{
            let data = arr_doctorList[indexPath.row]
            cell.setDrList(data: data)
        }

        tableView.separatorColor = UIColor.clear
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "DoctorDetailsViewController") as! DoctorDetailsViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}



extension DoctorListViewController{
    
    func doctorListAPICall()
    {
        self.view.makeToastActivity(.center)
        let url = UrlString().getDoctorListBySpecialityURL()
         WebserviceHelper.sharedInstance.getData(URL: url, parameterDict: getDoctorListParam(specialityId: specialityId), methodType: .post, headerDict: getheader(), Encoding: URLEncoding.default, successBlock:{
            (responseData) in
            do
            {
                let doctorListData = try JSONDecoder().decode(DoctorListModel.self, from: responseData!)
                if doctorListData.code == 1
                {
                    self.displayTextMessage(msg: doctorListData.message!)
                    self.tableView.isHidden = true
                }else{
                    self.tableView.isHidden = false
                }
                
                if doctorListData.results != nil
                {
                    self.arr_doctorList = doctorListData.results!
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
    
    
    
    func doctorLikeAPICall(doctorId: Int)
    {
        self.view.makeToastActivity(.center)
        let url = UrlString().doctorFavouriteURL()
        
        
        WebserviceHelper.sharedInstance.getData(URL: url, parameterDict: getFavParam(doctorId: doctorId, patientId: "157"), methodType: .post, headerDict: getheader() , Encoding: JSONEncoding.default, successBlock:{
            (responseData) in
            do
            {
                let data = try JSONDecoder().decode(DoctorFavModel.self, from: responseData!)
                
                if data.code == 1
                {
                    
                }
                
                self.tableView.reloadData()

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

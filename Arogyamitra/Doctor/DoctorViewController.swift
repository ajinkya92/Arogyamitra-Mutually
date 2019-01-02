//
//  DoctorViewController.swift
//  Arogyamitra
//
//  Created by Nitin Landge on 09/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import UIKit

class DoctorViewController: UIViewController {

    @IBOutlet private weak var textField_search: UITextField!
    @IBOutlet private weak var view_search: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var arr_doctor = [DoctorResultArray]()
    var arr_doctorSearchResult = [DoctorSearchResult]()
    var isSearching = false
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField_search.layer.borderColor = UIColor.lightGray.cgColor
        textField_search.layer.borderWidth = 1
        view_search.layer.borderColor = UIColor.lightGray.cgColor
        view_search.layer.borderWidth = 1
        textField_search.layer.sublayerTransform = CATransform3DMakeTranslation(12, 0, 0)
        doctorAPICall()
        doctorSearchAPICall()
    }

}
extension DoctorViewController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if isSearching {
            return 1//searchFilterData.count
        } else {
        return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if isSearching {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorSearch", for: indexPath) as! DoctorSearchTableViewCell

//            cell.configureAutoCompleteCell(resultData: searchFilterData[indexPath.row])
            
            return cell
            
        } else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DoctorTableViewCell
            if arr_doctor.count > 0{
                let data = arr_doctor[indexPath.row]
                cell.setDoctorData(data: data)
            }
            tableView.separatorColor = UIColor.clear
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "DoctorListViewController") as! DoctorListViewController
        let data = arr_doctor[indexPath.row]
       viewController.specialityId = data.speciality_id!
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}



extension DoctorViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField_search.resignFirstResponder()
        textField_search.text = ""
        tableView.reloadData()
        return true
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if textField_search.text != "" {
            
            isSearching = true
//            searchFilterData = laboratoryByAutoCompleteSearchArray.filter({$0.label.lowercased().prefix((textField.text?.count)!) == textField.text!.lowercased()})
//            tableView.reloadData()
        } else {
            isSearching = false
            tableView.reloadData()
            textField_search.resignFirstResponder()
        }
        
        
        
    }
    
    
}

extension DoctorViewController{
    
    func doctorAPICall()
    {
        self.view.makeToastActivity(.center)
        let url = UrlString().getDoctorURL()
        
        
        WebserviceHelper.sharedInstance.getData(URL: url, parameterDict: Parameters(), methodType: .get, headerDict: getheaderOfContentType(), Encoding: JSONEncoding.default, successBlock:{
            (responseData) in
            do
            {
                let doctorData = try JSONDecoder().decode(DoctorModel.self, from: responseData!)
                
                if doctorData.results != nil
                {
                    self.arr_doctor = doctorData.results!
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
    
    
    func doctorSearchAPICall()
    {
        self.view.makeToastActivity(.center)
        let url = UrlString().getDoctorSearchURL()
        
        
        WebserviceHelper.sharedInstance.getData(URL: url, parameterDict: Parameters(), methodType: .get, headerDict: getheaderOfContentType(), Encoding: JSONEncoding.default, successBlock:{
            (responseData) in
            do
            {
                let doctorSearchData = try JSONDecoder().decode(DoctorSearchModel.self, from: responseData!)
                
                if doctorSearchData.results != nil
                {
                    self.arr_doctorSearchResult = doctorSearchData.results!
//                    self.tableView.reloadData()
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




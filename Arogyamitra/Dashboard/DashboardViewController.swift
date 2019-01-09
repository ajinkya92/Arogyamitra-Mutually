//
//  DashboardViewController.swift
//  Arogyamitra
//
//  Created by Nitin Landge on 07/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var collectionView_dashboard: UICollectionView!
    
    var arr_dashboard = [DashboardResultArray]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden = true

        dashboardAPICall()
        
        let collectionViewLayout = collectionView_dashboard.collectionViewLayout as? UICollectionViewFlowLayout
        collectionViewLayout?.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        collectionViewLayout?.invalidateLayout()
    }
    @objc func clickButton()
    {
        self.slideMenuController()?.openLeft()
    }
    
    func goToContainerViewController()
    {
        let containerViewController = self.storyboard?.instantiateViewController(withIdentifier: "ContainerViewController") as! ContainerViewController
        self.navigationController?.pushViewController(containerViewController, animated: false)
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationItem.hidesBackButton = true

    }

}
extension DashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    //MARK: Collection View Methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return arr_dashboard.count - 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView_dashboard.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)as! DashboardCollectionViewCell
        if arr_dashboard.count > 0
        {
            let data = arr_dashboard[indexPath.row]
            cell.setDashboardData(data: data)
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        switch indexPath.row {
        case 0:
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "DoctorViewController") as! DoctorViewController
            self.navigationController?.pushViewController(viewController, animated: true)
            break
            
        case 1:
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "HospitalListViewController") as! HospitalListViewController
            self.navigationController?.pushViewController(viewController, animated: true)
            break
        case 2:
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "DoctorViewController") as! DoctorViewController
            self.navigationController?.pushViewController(viewController, animated: true)
            break
            
        case 5:
            let physicalFitnessVC = self.storyboard?.instantiateViewController(withIdentifier: "PhysicalFitnessViewController") as! PhysicalFitnessViewController
            physicalFitnessVC.arr_dashboard = arr_dashboard
            self.navigationController?.pushViewController(physicalFitnessVC, animated: true)
            break
            
        case 4:
            let physicalFitnessVC = self.storyboard?.instantiateViewController(withIdentifier: "LaboratoryViewController") as! LaboratoryViewController
            self.navigationController?.pushViewController(physicalFitnessVC, animated: true)
            break
            
        case 7:
            
            let ajinkyaStroryboard = UIStoryboard.init(name: "Ajinkya", bundle: nil)
            guard let arogyamVc = ajinkyaStroryboard.instantiateViewController(withIdentifier: "ArogyamVC") as? ArogyamVC else {return}
            arogyamVc.title = "Navigation"
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            self.navigationController?.pushViewController(arogyamVc, animated: true)
            break
            
        default:
            break
        }
        
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//            return UIEdgeInsets(top: 100, left: 0, bottom: 10, right: 0)
//        }
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
//    {
//        let equalHeight_Width = (collectionView_dashboard.frame.width)/2 - 10
//        return CGSize(width: 100, height: 100)
//    }
}


extension DashboardViewController{
    
    func dashboardAPICall()
    {
        self.view.makeToastActivity(.center)
        let url = UrlString().getDashboardURL()
        
        
        WebserviceHelper.sharedInstance.getData(URL: url, parameterDict: Parameters(), methodType: .get, headerDict: getheaderOfContentType(), Encoding: JSONEncoding.default, successBlock:{
            (responseData) in
            do
            {
                let dashboardData = try JSONDecoder().decode(DashboardModel.self, from: responseData!)
                
                if dashboardData.results != nil
                {
                    self.arr_dashboard = dashboardData.results!
                    self.collectionView_dashboard.reloadData()
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

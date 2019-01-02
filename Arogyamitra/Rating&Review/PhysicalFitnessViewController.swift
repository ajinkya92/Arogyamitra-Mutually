//
//  PhysicalFitnessViewController.swift
//  Arogyamitra
//
//  Created by Sangram Powar on 23/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import UIKit

class PhysicalFitnessViewController: UIViewController {
    
    @IBOutlet weak var collectionView_dashboard: UICollectionView!
    
    var arr_dashboard = [DashboardResultArray]()
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

extension PhysicalFitnessViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    //MARK: Collection View Methods
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView_dashboard.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)as! DashboardCollectionViewCell
        if arr_dashboard.count > 0
        {
            let range = arr_dashboard.index(arr_dashboard.endIndex, offsetBy: -4) ..< arr_dashboard.endIndex
            let arr = arr_dashboard[range]
            let newArray = Array(arr)
            
            let data = newArray[indexPath.row]
            cell.setDashboardData(data: data)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        //MARK: Start the Project From here - Ajinkya Sonar.
        
//        switch indexPath.row {
//        case 0:
//            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "DoctorViewController") as! DoctorViewController
//            self.navigationController?.pushViewController(viewController, animated: true)
//            break
//
//        case 1:
//            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "HospitalListViewController") as! HospitalListViewController
//            self.navigationController?.pushViewController(viewController, animated: true)
//            break
//        case 2:
//            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "DoctorViewController") as! DoctorViewController
//            self.navigationController?.pushViewController(viewController, animated: true)
//            break
//        default:
//            break
//        }
        
        let ajinkyaStoryboard = UIStoryboard.init(name: "Ajinkya", bundle: nil)
        
        switch indexPath.row {
        case 0:
            guard let gymnaisumVc = ajinkyaStoryboard.instantiateViewController(withIdentifier: "GymnasiumVC") as? GymnasiumVC else {return}
            gymnaisumVc.title = "Gymnasium"
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            self.navigationController?.pushViewController(gymnaisumVc, animated: true)
            
        default:
            break
        }

    }
    
}

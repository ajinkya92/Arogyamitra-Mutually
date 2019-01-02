//
//  ServicesViewController.swift
//  Arogyamitra
//
//  Created by Nitin Landge on 16/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import UIKit

class ServicesViewController: UIViewController {

    @IBOutlet weak var collectionView_services: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
 
}

extension ServicesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    //MARK: Collection View Methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView_services.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)as! ServicesCollectionViewCell
//        if arr_dashboard.count > 0
//        {
//            let data = arr_dashboard[indexPath.row]
//            cell.setDashboardData(data: data)
//        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
//        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "DoctorViewController") as! DoctorViewController
//        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
//        {
//            let equalHeight_Width = (collectionView_services.frame.width)/2
//            return CGSize(width: equalHeight_Width, height: 30)
//        }
}

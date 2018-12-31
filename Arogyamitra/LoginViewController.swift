//
//  LoginViewController.swift
//  Arogyamitra
//
//  Created by Nitin Landge on 07/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // goToContainerViewController()
    }
    func goToContainerViewController()
    {
        let containerViewController = self.storyboard?.instantiateViewController(withIdentifier: "ContainerViewController") as! ContainerViewController
        self.navigationController?.pushViewController(containerViewController, animated: false)
    }
    
    //MARK: Button Actions
    
    @IBAction func btn_sideMenuPressed(_ sender: Any) {
       // self.slideMenuController()?.openLeft()
        
        goToContainerViewController()
        
//        let dashboardViewController = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
//        self.navigationController?.pushViewController(dashboardViewController, animated: true)
    }
}


//
//  ContainerViewController.swift
//  CFL FI
//
//  Created by Nitin Landge on 01/04/76.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import UIKit

class ContainerViewController: SlideMenuController
{
    override func awakeFromNib()
    {
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController")
        {
            self.mainViewController = controller
           
            self.navigationItem.hidesBackButton = true
            let testUIBarButtonItem = UIBarButtonItem(image: UIImage(named: "sideMenu"), style: .plain, target: self, action: #selector(self.clickButton))
            self.navigationItem.leftBarButtonItem = testUIBarButtonItem
            self.title = "Arogyamitra"

            let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
            navigationController?.navigationBar.tintColor = UIColor.white
            
            
            
//            let loactionButton = UIBarButtonItem(image: UIImage(named: "icon_location"), style: .plain, target: self, action: #selector(self.locationclickButton))
//            self.navigationItem.rightBarButtonItem = loactionButton
            

            
            let view = UIView()
            let button = UIButton(type: .system)
            button.semanticContentAttribute = .playback
            button.setImage(UIImage(named: "icon_location"), for: .normal)
            button.setTitle("Location", for: .normal)
            button.addTarget(self, action: #selector(locationclickButton), for: .touchUpInside)
            button.sizeToFit()
            view.addSubview(button)
            view.frame = button.bounds
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: view)
            
        }

        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "MenuDrawerViewController")
        {
            self.leftViewController = controller
        }
        super.awakeFromNib()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @objc func clickButton()
    {
//        self.slideMenuController()?.openLeft()
    }
    @objc func locationclickButton()
    {
        let vc = LocationStoryboard.instantiateViewController(withIdentifier: "LocationSearchViewController") as! LocationSearchViewController
        self.title = ""

        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


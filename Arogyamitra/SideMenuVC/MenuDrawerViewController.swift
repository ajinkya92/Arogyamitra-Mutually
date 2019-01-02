//
//  MenuDrawerViewController.swift
//  CFL FI
//
//  Created by Nitin Landge on 01/04/76.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import UIKit

class MenuDrawerViewController: UIViewController
{
    let menuList:[String] = ["Change Password", "Logout"]
    let menuImagesArray:[UIImage] = []
    
    var filterdItemsArray = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btn_Profile: UIButton!
    @IBOutlet weak var label_userName: UILabel!
    @IBOutlet weak var label_userEmail: UILabel!
    
    @IBOutlet weak var imgView_ProfileImage_Drawer: UIImageView!
    
    //MARK:- View Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
    } 
}

extension MenuDrawerViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let menuCell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)as! MenuDrawerTableViewCell
        menuCell.lbl_MenuName.text = menuList[indexPath.row]
        return menuCell
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let selectedIndex = indexPath.row

         if(selectedIndex == 0)// "ChangePassword"
        {
//            let changePasswordViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordViewController") as! ChangePasswordViewController
//            self.slideMenuController()?.changeMainViewController(changePasswordViewController, close: true)
        }
        else if(selectedIndex == 1)//Logout
        {
//            let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//            self.slideMenuController()?.changeMainViewController(loginViewController, close: true)
        }
            
        else
        {
//            let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//            self.slideMenuController()?.changeMainViewController(loginViewController, close: true)
        }
    }
    
}



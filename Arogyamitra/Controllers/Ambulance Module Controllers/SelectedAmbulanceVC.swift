//
//  SelectedAmbulanceVC.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 16/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

import UIKit
import Kingfisher

class SelectedAmbulanceVC: UIViewController {
    
    //OUTLETS
    @IBOutlet weak var innerContentView: UIView!
    @IBOutlet weak var ambulanceImage: UIImageView!
    @IBOutlet weak var ambulanceTypeLbl: UILabel!
    @IBOutlet weak var ambulanceNameLbl: UILabel!
    @IBOutlet weak var contactNumberBtn: UIButton!
    @IBOutlet weak var driverNameLbl: UILabel!
    @IBOutlet weak var chargesLbl: UILabel!
    @IBOutlet weak var vehicleNumLbl: UILabel!
    @IBOutlet weak var outStationServiceImage: UIImageView!
    @IBOutlet weak var innerContentViewBookBtn: UIButton!
    @IBOutlet weak var innerContentViewCloseBtn: UIButton!
    
    //Small POPUP View Outlets
    @IBOutlet weak var smallPopupView: UIView!
    
    
    //Animating Outlets - Constratints
    @IBOutlet weak var smallPopupViewCenterShiftConstraint: NSLayoutConstraint!
    

    var requiedValuesDictionary = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAllDisplayElements()
    }
    
    //ACTIONS
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Mobile Number Call Action
    @IBAction func mobileNumberBtnTapped(_ sender: UIButton) {
        let mobileNumber = requiedValuesDictionary["mobileNumber"] as? String
        
        if let mobileNumber = mobileNumber {
            if let url = URL(string: "tel://\(mobileNumber)"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
    
    @IBAction func innerContentViewBookBtnTapped(_ sender: UIButton) {
        
        smallPopupViewCenterShiftConstraint.constant = 0
        innerContentViewBookBtn.setTitle("Processing", for: .normal)
        innerContentViewCloseBtn.isHidden = true
        UIView.animate(withDuration: 1.0) {
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: SMALL POPUP VIEW ACTIONS
    
    @IBAction func smallPopupViewCloseBtnTapped(_ sender: UIButton) {
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            smallPopupViewCenterShiftConstraint.constant = -500
        }else {
            smallPopupViewCenterShiftConstraint.constant = -1200
        }
        
        innerContentViewCloseBtn.isHidden = false
        innerContentViewBookBtn.setTitle("Book", for: .normal)
        
        UIView.animate(withDuration: 1.0) {
            self.view.layoutIfNeeded()
        }
        
    }
    

}

//MARK: Set Display Elements on View Did Load
extension SelectedAmbulanceVC {
    
    func setAllDisplayElements() {
        self.view.makeToastActivity(.center)
        innerContentView.layer.cornerRadius = 5
        guard let ambulanceImageUrl = URL(string: requiedValuesDictionary["ambulanceImage"] as! String) else {return}
        ambulanceImage.kf.setImage(with: ambulanceImageUrl)
        
        if let ambulanceTypeString = requiedValuesDictionary["ambulanceType"] {
            ambulanceTypeLbl.text = "Type - \(ambulanceTypeString as? String ?? "")"
        }
        
        ambulanceNameLbl.text = requiedValuesDictionary["ambulanceName"] as? String
        contactNumberBtn.setTitle(requiedValuesDictionary["mobileNumber"] as? String, for: .normal)
        driverNameLbl.text = requiedValuesDictionary["driverName"] as? String
        
        if let chargesString = requiedValuesDictionary["charges"] {
            chargesLbl.text =  "Rs. \((chargesString as? String ?? ""))/- per km"
        }
        
        if let vehicleNumberString = requiedValuesDictionary["vehicleNumber"] {
            vehicleNumLbl.text = (vehicleNumberString as? String ?? "")
        }
        
        let outOfStationServiceValue = requiedValuesDictionary["outOfStationServices"] as? Int
        
        if let outOfStationServiceValue = outOfStationServiceValue {
            
            if outOfStationServiceValue != 0 {
                outStationServiceImage.image = UIImage(named: "checked")
            }else {outStationServiceImage.image = UIImage(named: "cancelRed")}
            
        }
        
        smallPopupView.layer.borderWidth = 1.0
        smallPopupView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        smallPopupView.layer.cornerRadius = 5.0
        smallPopupView.clipsToBounds = true
        
        //Check If Iphone or Ipad and hide the smallPopupView
        if UIDevice.current.userInterfaceIdiom == .phone {
            smallPopupViewCenterShiftConstraint.constant = -500
            self.view.layoutIfNeeded()
        }else {
            smallPopupViewCenterShiftConstraint.constant = -1200
            self.view.layoutIfNeeded()
        }
        
        
        
        self.view.hideToastActivity()
        
    }
    
}

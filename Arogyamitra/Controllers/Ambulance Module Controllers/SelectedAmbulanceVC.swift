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
    @IBOutlet weak var bookBtn: UIButton!
    

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

}

//MARK: Set Display Elements on View Did Load
extension SelectedAmbulanceVC {
    
    func setAllDisplayElements() {
        self.view.makeToastActivity(.center)
        innerContentView.layer.cornerRadius = 5
        guard let ambulanceImageUrl = URL(string: requiedValuesDictionary["ambulanceImage"] as! String) else {return}
        ambulanceImage.kf.setImage(with: ambulanceImageUrl)
        ambulanceTypeLbl.text = "Type - \(requiedValuesDictionary["ambulanceType"] ?? "")"
        ambulanceNameLbl.text = requiedValuesDictionary["ambulanceName"] as? String
        contactNumberBtn.setTitle(requiedValuesDictionary["mobileNumber"] as? String, for: .normal)
        driverNameLbl.text = requiedValuesDictionary["driverName"] as? String
        chargesLbl.text = "Rs. \(requiedValuesDictionary["charges"]  ?? "")/- per km"
        vehicleNumLbl.text = "\(requiedValuesDictionary["vehicleNumber"] ?? "")"
        let outOfStationServiceValue = requiedValuesDictionary["outOfStationServices"] as? Int
        
        if let outOfStationServiceValue = outOfStationServiceValue {
            
            if outOfStationServiceValue != 0 {
                outStationServiceImage.image = UIImage(named: "checked")
            }else {outStationServiceImage.image = UIImage(named: "cancelRed")}
            
        }
        
        self.view.hideToastActivity()
        
    }
    
}

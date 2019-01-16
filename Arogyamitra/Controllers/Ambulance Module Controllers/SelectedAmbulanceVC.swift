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

}

//MARK: Set Display Elements on View Did Load
extension SelectedAmbulanceVC {
    
    func setAllDisplayElements() {
        self.view.makeToastActivity(.center)
        guard let ambulanceImageUrl = URL(string: requiedValuesDictionary["ambulanceImage"] as! String) else {return}
        ambulanceImage.kf.setImage(with: ambulanceImageUrl)
        ambulanceTypeLbl.text = "Type - \(requiedValuesDictionary["ambulanceType"] ?? "")"
        self.view.hideToastActivity()
        
    }
    
}

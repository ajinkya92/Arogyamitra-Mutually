//
//  RatingAndReviewViewController.swift
//  Arogyamitra
//
//  Created by Nitin Landge on 14/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import UIKit
import Kingfisher

class RatingAndReviewViewController: UIViewController {

    var arr_doctorDetails = [DoctorDetails]()
    var arr_hospitalDetails = [HospitalDetailsResult]()
    var isFromHospital = Bool()
    
    //MARK: Changes Done By Ajinkya
    var bgImagePassedFromOtherVC: String?

    @IBOutlet weak var label_drName: UILabel!
    @IBOutlet weak var imageView_bgImage: UIImageView!
    @IBOutlet weak var imageView_drImage: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Changes Done By Ajinkya
        if let bgImageString = bgImagePassedFromOtherVC {
            print(bgImageString)
        }else {return}

        // Do any additional setup after loading the view.
        
        /*
       
        if isFromHospital
        {
            label_drName.text = arr_hospitalDetails.first?.hospital_name
            
            let imageStr = arr_hospitalDetails.first?.hospital_background_photo!
            imageView_bgImage.kf.setImage(with: URL(string:imageStr!
                .replacingOccurrences(of: " ", with: "%20")), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
            
//            imageView_drImage.kf.setImage(with: URL(string:(arr_hospitalDetails.first?.doctor_photo!
//                .replacingOccurrences(of: " ", with: "%20"))!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
            
        }else{
        label_drName.text = arr_doctorDetails.first?.doctor_name
        let imageStr = arr_doctorDetails.first?.hospital_background_photo!
        imageView_bgImage.kf.setImage(with: URL(string:imageStr!
            .replacingOccurrences(of: " ", with: "%20")), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        imageView_drImage.kf.setImage(with: URL(string:(arr_doctorDetails.first?.doctor_photo!
            .replacingOccurrences(of: " ", with: "%20"))!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
            
        }
 
 */
    }

}

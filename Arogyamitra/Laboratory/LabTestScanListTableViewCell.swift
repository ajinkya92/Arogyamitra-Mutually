//
//  LabTestScanListTableViewCell.swift
//  Arogyamitra
//
//  Created by Sangram Powar on 29/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import UIKit

class LabTestScanListTableViewCell: UITableViewCell {

    @IBOutlet weak var label_testName: UILabel!
    @IBOutlet weak var label_testAmt: UILabel!
    @IBOutlet weak var label_testScanID: UILabel!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLabTestList(data : Test_scan_list2)  {
        
    }

}

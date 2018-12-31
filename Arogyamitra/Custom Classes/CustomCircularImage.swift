//
//  CustomCircularImage.swift
//  Clappily
//
//  Created by Nitin Landge on 3/17/18.
//  Copyright © 2018 Kalpesh Thakare. All rights reserved.
//

import UIKit

class CustomCircularImage: UIImageView {
    
    @IBInspectable var borderWidth: Int = 0
    @IBInspectable var borderColor: UIColor?
    
    override init(image: UIImage?) {
        super.init(image: image)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
        layer.borderWidth = CGFloat(borderWidth)
        layer.borderColor = borderColor?.cgColor
    }
}


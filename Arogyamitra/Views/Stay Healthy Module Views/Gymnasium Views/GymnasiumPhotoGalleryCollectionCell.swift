//
//  GymnasiumPhotoGalleryCollectionCell.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 05/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

import UIKit
import Kingfisher

class GymnasiumPhotoGalleryCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    func configureGymnasiumImageGalleryCell(gymnasiumPhotoGalleryImages: GymnasiumDetailsServiceGymnasiumYogaGallery) {
        
        guard let photoGalleryImageUrl = URL(string: gymnasiumPhotoGalleryImages.photo) else {return}
        self.photoImageView.kf.setImage(with: photoGalleryImageUrl)
        
    }
    
}

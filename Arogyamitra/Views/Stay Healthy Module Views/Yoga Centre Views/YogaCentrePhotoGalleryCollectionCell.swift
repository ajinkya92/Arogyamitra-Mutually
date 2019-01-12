//
//  YogaCentrePhotoGalleryCollectionCell.swift
//  Arogyamitra
//
//  Created by Aditya Infotech on 07/01/19.
//  Copyright © 2019 Nitin Landge. All rights reserved.
//

import UIKit
import Kingfisher

class YogaCentrePhotoGalleryCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    func configureYogaCentreImageGalleryCell(yogaCentrePhotoGalleryImages: GymnasiumDetailsServiceGymnasiumYogaGallery) {
        
        guard let photoGalleryImageUrl = URL(string: yogaCentrePhotoGalleryImages.photo) else {return}
        self.photoImageView.kf.setImage(with: photoGalleryImageUrl)
    }
    
}

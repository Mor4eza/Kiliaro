//
//  ImageCell.swift
//  Kiliaro
//
//  Created by Morteza on 11/20/21.
//

import UIKit
import Kingfisher

class ImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var sizeLabel: UILabel!
    
    func setupCell(image: ImageModel) {
        
        //append thumbnail url params
        guard let url = URL(string: image.thumbnailUrl + "?w=250&h=250&m=md")  else {
            return
        }
        
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(systemName: "photo.on.rectangle.fill"),
            options: [
                .loadDiskFileSynchronously,
                .cacheOriginalImage,
                .transition(.fade(0.25)),
            ]
        )
        
        sizeLabel.text = " Size: \(calculateSizeInMB(size: image.size)) MB "
        sizeLabel.layer.masksToBounds = true
        sizeLabel.backgroundColor = .lightGray
        sizeLabel.layer.cornerRadius = 8.0
        sizeLabel.textColor = .white
    }
    
    func calculateSizeInMB(size: Int64) ->  Double {
        let MBvalue  = Double(size) / (1_024 * 1_024)
        return MBvalue.rounded(.up)
    }
}

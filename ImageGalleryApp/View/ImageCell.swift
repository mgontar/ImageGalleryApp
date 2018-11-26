//
//  ImageCell.swift
//  ImageGalleryApp
//
//  Created by Admin on 11/26/18.
//  Copyright © 2018 Maksym Gontar. All rights reserved.
//

import UIKit
import AlamofireImage

class ImageCell: UICollectionViewCell {

    static let placeholder = "ImageCell"
    static let nibName = "ImageCell"
    
    @IBOutlet weak var imgView: UIImageView!
    
    var image: Image!
    {
        didSet {
            if let url = URL(string: image.url) {
                let placeholderImage = UIImage(named:"icon_photo")
                imgView.af_setImage(withURL: url, placeholderImage: placeholderImage)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

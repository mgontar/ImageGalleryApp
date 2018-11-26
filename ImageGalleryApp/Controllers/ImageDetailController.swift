//
//  ImageDetailController.swift
//  ImageGalleryApp
//
//  Created by Admin on 11/26/18.
//  Copyright © 2018 Maksym Gontar. All rights reserved.
//

import UIKit

class ImageDetailController: UIViewController {
    
    static let identifier = "ImageDetailController"

    @IBOutlet weak var imgCollectionView: UICollectionView!
    
    var selectedImageIndexPath:IndexPath!
    var images = [Image]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        imgCollectionView.setNeedsLayout()
        imgCollectionView.layoutIfNeeded()
        
        imgCollectionView.scrollToItem(at: selectedImageIndexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: false)
    }
    
    func setupCollectionView() {
        let nib = UINib(nibName: ImageCell.nibName, bundle: nil)
        imgCollectionView?.register(nib, forCellWithReuseIdentifier: ImageCell.placeholder)
        imgCollectionView.reloadData()
    }
}

extension ImageDetailController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.placeholder, for: indexPath) as! ImageCell
        cell.image = images[indexPath.row]
        return cell
    }
}

extension ImageDetailController: UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

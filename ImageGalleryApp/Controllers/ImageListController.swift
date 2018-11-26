//
//  ViewController.swift
//  ImageGalleryApp
//
//  Created by Admin on 11/26/18.
//  Copyright © 2018 Maksym Gontar. All rights reserved.
//

import UIKit

class ImageListController: UIViewController {

    @IBOutlet weak var imgCollectionView: UICollectionView!
    
    var images = [Image]()
    
    let minCellSpacing:CGFloat = 8
    let minLineSpacing:CGFloat = 8
    let columnCount:CGFloat = 2
    
    private let refreshControl = UIRefreshControl()

    private let imageManager = ImageManager.shared()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchData()
    }
    
    func setupCollectionView() {
        refreshControl.tintColor = .white
        if #available(iOS 10.0, *) {
            imgCollectionView.refreshControl = refreshControl
        } else {
            imgCollectionView.addSubview(refreshControl)
        }

        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        let nib = UINib(nibName: ImageCell.nibName, bundle: nil)
        imgCollectionView?.register(nib, forCellWithReuseIdentifier: ImageCell.placeholder)
    }
    
    @objc private func refreshData(_ sender: Any) {
        fetchData(isPull: true)
    }
    
    private func fetchData(isPull:Bool = false) {
        
        if !isPull {
            activityIndicator.startAnimating()
        }
        
        imageManager.getAllImages() { (images, error) in
            DispatchQueue.main.async {
                self.images = images
                self.imgCollectionView.reloadData()
                self.refreshControl.endRefreshing()
                if !isPull {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
}

extension ImageListController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: ImageDetailController.identifier) as! ImageDetailController
        newViewController.images = self.images
        newViewController.selectedImageIndexPath = indexPath
        self.navigationController?.show(newViewController, sender: nil)
    }
}

extension ImageListController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.placeholder, for: indexPath) as! ImageCell
        cell.image = images[indexPath.row]
        return cell
    }
}

extension ImageListController: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sideSize = collectionView.frame.size.width/columnCount - minCellSpacing*(columnCount-1)
        return CGSize(width: sideSize, height: sideSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minCellSpacing
    }
}

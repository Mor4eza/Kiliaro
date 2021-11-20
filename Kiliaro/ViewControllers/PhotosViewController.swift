//
//  PhotosViewController.swift
//  Kiliaro
//
//  Created by Morteza on 11/20/21.
//

import UIKit
import Kingfisher

class PhotosViewController: UIViewController {

    @IBOutlet weak var imagesCollectionView: UICollectionView!
    var imageViewModel = ImageViewModel()
    var images = [ImageModel]() {
        didSet {
            imagesCollectionView.reloadData()
        }
    }
    
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchData()
    }
    
    func setupCollectionView() {
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        imagesCollectionView.setCollectionViewLayout(layout, animated: true)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        imagesCollectionView.refreshControl = refreshControl
    }
    
    func fetchData() {
        self.refreshControl.beginRefreshing()
        imageViewModel.fetchImages { result in
            self.refreshControl.endRefreshing()
            switch result {
                case .success(let images):
                    self.images = images
                    
                case .failure(let error):
                    print(error)
            }
            
        }
    }
    
    @objc func refreshData() {
        ImageCache.default.clearCache()
        ImageCache.default.clearDiskCache()
        fetchData()
    }
}

extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCell
        cell.setupCell(image: images[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = 3
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        return CGSize(width: size, height: size)
    }
}

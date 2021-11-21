//
//  imageDetailsViewController.swift
//  Kiliaro
//
//  Created by Morteza on 11/20/21.
//

import UIKit

class ImageDetailsViewController: UIViewController {

    lazy var imageView = UIImageView()
    lazy var dateLabel = UILabel()
    var image: ImageModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        title = "Photo Details"
        if let image = image, let url = URL(string: image.downloadUrl) {
            
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: url)
            dateLabel.text = "Created At: \(image.created_at)"
        }
        
    }
    
    func setupView() {
        self.view.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textAlignment = .center
        dateLabel.textColor = .lightGray
        self.view.addSubview(imageView)
        self.view.addSubview(dateLabel)
        
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        dateLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50.0).isActive = true


    }

}

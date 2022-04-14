//
//  ImageCatalogView.swift
//  MemeGen
//
//  Created by Евгения Шарамет on 14.04.2022.
//

import Foundation
import UIKit

class ImageCatalogView: UIView {
    let imageCollection: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()

    func prepare() {
        self.backgroundColor = .systemGray6
        setupImageCollection()
        //self.addSubview(imageCollection)
    }
    
    func setupImageCollection() {
        self.addSubview(imageCollection)
        imageCollection.backgroundColor = .lightGray
        imageCollection.translatesAutoresizingMaskIntoConstraints = false
        imageCollection.topAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 20).isActive = true
        imageCollection.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        imageCollection.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        imageCollection.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

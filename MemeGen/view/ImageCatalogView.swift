//
//  ImageCatalogView.swift
//  MemeGen
//
//  Created by Евгения Шарамет on 14.04.2022.
//

import Foundation
import UIKit

class ImageCatalogView: UIView {
    //MARK: - data
    
    let imageCollection: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    let appNameLabel = UILabel()
    
    //MARK: - public functions
    
    init() {
        super.init(frame: .zero)
        prepare()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - private functions
    
    private func prepare() {
        self.backgroundColor = .systemGray6
        setupAppNameLabel()
        setupImageCollection()
    }
    
    private func setupAppNameLabel() {
        self.addSubview(appNameLabel)
        appNameLabel.translatesAutoresizingMaskIntoConstraints = false
        appNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        appNameLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        appNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        appNameLabel.font = UIConst.appNameFont
        appNameLabel.textAlignment = .center
        appNameLabel.text = "All Memes!"
    }
    
    private func setupImageCollection() {
        self.addSubview(imageCollection)
        imageCollection.translatesAutoresizingMaskIntoConstraints = false
        imageCollection.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        imageCollection.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        imageCollection.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        imageCollection.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        imageCollection.backgroundColor = .systemGray6
    }
}

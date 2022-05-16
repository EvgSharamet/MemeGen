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
    let updateButton = UIButton()
    let spinner = SpinnerView()
    
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
        setupUpdateButton()
        setupSpinnerView()
    }
    
    private func setupAppNameLabel() {
        let appNameLabel = UILabel()
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
    
    private func setupUpdateButton() {
        self.addSubview(updateButton)
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        updateButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -15).isActive = true
        updateButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -15).isActive = true
        updateButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        updateButton.backgroundColor = .purple
        updateButton.layer.cornerRadius = 10
        updateButton.setTitle("Update", for: .normal)
    }
    
    private func setupSpinnerView() {
        self.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.stretch()
        spinner.isHidden = true
    }
}

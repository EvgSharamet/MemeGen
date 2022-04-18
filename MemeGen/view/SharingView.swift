//
//  SharingView.swift
//  MemeGen
//
//  Created by Евгения Шарамет on 15.04.2022.
//

import Foundation
import UIKit

class SharingView: UIView {
    //MARK: - data
    
    let imageView = UIImageView()
    
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
        self.backgroundColor = .systemGroupedBackground
        setupLabel()
        setupImageView()
        setupButtonsStack()
    }
    
    private func setupLabel() {
        let headerLabel = UILabel()
        self.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        headerLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        headerLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, constant: -30).isActive = true
        headerLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        headerLabel.textAlignment = .center
        headerLabel.font = UIConst.sharingLabelFont
        headerLabel.text = "Looks amazing!"
    }
    
    private func setupImageView() {
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        imageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, constant: -30).isActive = true
        imageView.layer.cornerRadius = 40
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "meme")
    }
    
    private func setupButtonsStack() {
        let stack = UIStackView()
        self.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -60).isActive = true
        stack.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, constant: -100).isActive = true
        stack.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        stack.heightAnchor.constraint(equalToConstant: 60).isActive = true
        stack.distribution = .equalSpacing
        
        let saveButton = UIButton()
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(saveButton)
        saveButton.layer.cornerRadius = 30
        saveButton.widthAnchor.constraint(equalTo: stack.heightAnchor).isActive = true
        saveButton.setBackgroundImage(UIImage(named: "saveInGallery"), for: .normal)
        saveButton.backgroundColor = .systemGray
        saveButton.layer.masksToBounds = true
        saveButton.backgroundColor = .white
        
        let instagramButton = UIButton()
        instagramButton.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(instagramButton)
        instagramButton.widthAnchor.constraint(equalTo: stack.heightAnchor).isActive = true
        instagramButton.layer.cornerRadius = 30
        instagramButton.backgroundColor = .lightGray
        instagramButton.setBackgroundImage(UIImage(named: "instagram"), for: .normal)
        instagramButton.layer.masksToBounds = true
        
        let facebookButton = UIButton()
        facebookButton.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(facebookButton)
        facebookButton.widthAnchor.constraint(equalTo: stack.heightAnchor).isActive = true
        facebookButton.layer.cornerRadius = 30
        facebookButton.backgroundColor = .darkGray
        facebookButton.setBackgroundImage(UIImage(named: "facebook"), for: .normal)
        facebookButton.layer.masksToBounds = true
    }
}

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
    let saveButton = UIButton()
    let sharingButton = UIButton()
    let popupView = UIView()
    
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
        setupLabel()
        setupImageView()
        setupSaveButton()
        setupSharingButton()
        setupPopupLabel()
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
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
    }
    
    private func setupSaveButton() {
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(saveButton)
        saveButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        saveButton.layer.cornerRadius = 10
        saveButton.backgroundColor = .purple
        saveButton.layer.masksToBounds = true
        saveButton.setTitle("Save", for: .normal)
    }
    
    private func setupSharingButton() {
        sharingButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(sharingButton)
        sharingButton.leftAnchor.constraint(equalTo: saveButton.rightAnchor, constant: 30).isActive = true
        sharingButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        sharingButton.widthAnchor.constraint(equalTo: sharingButton.heightAnchor).isActive = true
        sharingButton.layer.cornerRadius = 25
        sharingButton.backgroundColor = .clear
        sharingButton.centerYAnchor.constraint(equalTo: saveButton.centerYAnchor).isActive = true
        sharingButton.setImage(UIImage(named:"share"), for: .normal)
        sharingButton.contentMode = .scaleAspectFill
    }
    
    private func setupPopupLabel() {
        popupView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(popupView)
        popupView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        popupView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
        popupView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        popupView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        popupView.layer.masksToBounds = true
        popupView.layer.cornerRadius = 10
        
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        popupView.addSubview(blurEffectView)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.stretch()
        
        let popupLabel = UILabel()
        popupView.addSubview(popupLabel)
        popupLabel.translatesAutoresizingMaskIntoConstraints = false
        popupLabel.stretch()
        popupLabel.backgroundColor = .clear
        popupLabel.text = "Picture saved!"
        popupLabel.textAlignment = .center
        
        popupView.alpha = 0
    }
}

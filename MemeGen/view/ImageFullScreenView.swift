//
//  ImageFullScreenView.swift
//  MemeGen
//
//  Created by Евгения Шарамет on 15.04.2022.
//

import Foundation
import UIKit

class ImageFullScreenView: UIView {
    let fullImageView = UIImageView()
    let blurView = UIView()
    
    init() {
        super.init(frame: .zero)
        prepare()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepare() {
        self.backgroundColor = .systemGray6
        setupFullScreenView()
        setupBlackoutScreen()
        setupCenterBlurView()
        setupCenterStackView()
    }
    
    func setupFullScreenView() {
        self.addSubview(fullImageView)
        fullImageView.translatesAutoresizingMaskIntoConstraints = false
        fullImageView.stretchSafe()
        fullImageView.contentMode = .scaleAspectFit
        fullImageView.backgroundColor = .systemGroupedBackground
        fullImageView.image = UIImage(named: "meme")
    }
    
    func setupBlackoutScreen() {
        let blackoutView = UIView()
        self.addSubview(blackoutView)
        blackoutView.translatesAutoresizingMaskIntoConstraints = false
        blackoutView.stretch()
        blackoutView.backgroundColor = .black.withAlphaComponent(0.6)
    }
    
    func setupCenterBlurView() {
        self.addSubview(blurView)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        blurView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        blurView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        blurView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 40).isActive = true
        blurView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -40).isActive = true
        blurView.backgroundColor = .clear
        blurView.layer.masksToBounds = true
        
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurView.addSubview(blurEffectView)
        blurEffectView.stretch()
        blurView.layer.cornerRadius = 30
    }
    
    func setupCenterStackView() {
        let stack = UIStackView()
        blurView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.widthAnchor.constraint(equalTo: blurView.widthAnchor, constant:  -40).isActive = true
        stack.centerXAnchor.constraint(equalTo: blurView.centerXAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: blurView.centerYAnchor).isActive = true
        stack.heightAnchor.constraint(equalToConstant: 200).isActive = true
        stack.axis = .vertical
        stack.distribution = .fillEqually
        
        let topLabel = UILabel()
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(topLabel)
        topLabel.text = "TOP TEXT"
        topLabel.textAlignment = .natural
        topLabel.font = UIConst.fullScreenTopBottomLabelFont
        topLabel.backgroundColor = .clear
        topLabel.textColor = .white
        
        let topTextField = UITextField()
        topTextField.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(topTextField)
        topTextField.placeholder = "top_text"
        topTextField.setLeftPaddingPoints(10)
        topTextField.layer.cornerRadius = 10
        topTextField.backgroundColor = .white
        
        let bottomLabel = UILabel()
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(bottomLabel)
        bottomLabel.text = "BOTTOM TEXT"
        bottomLabel.font = UIConst.fullScreenTopBottomLabelFont
        bottomLabel.textColor = .white
        bottomLabel.backgroundColor = .clear
        
        let bottomTextField = UITextField()
        bottomTextField.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(bottomTextField)
        bottomTextField.placeholder = "bottom_text"
        bottomTextField.setLeftPaddingPoints(10)
        bottomTextField.layer.cornerRadius = 10
        bottomTextField.backgroundColor = .white
    }
}



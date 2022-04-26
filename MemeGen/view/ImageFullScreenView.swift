//
//  ImageFullScreenView.swift
//  MemeGen
//
//  Created by Евгения Шарамет on 15.04.2022.
//

import Foundation
import UIKit

class ImageFullScreenView: UIView {
    //MARK: - data
    
    let generateButton = UIButton()
    let fullImageView = UIImageView()
    let topTextField = UITextField()
    let bottomTextField = UITextField()
    let spinner = SpinnerView()
    
    private let blurView = UIView()

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
        setupFullScreenView()
        setupCenterBlurView()
        setupCenterStackView()
        setupGenerateButton()
        setupSpinnerView()
    }
    
    private func setupFullScreenView() {
        self.addSubview(fullImageView)
        fullImageView.translatesAutoresizingMaskIntoConstraints = false
        fullImageView.stretchSafe()
        fullImageView.contentMode = .scaleAspectFit
        fullImageView.backgroundColor = .systemGray6
    }
    
    private func setupBlackoutScreen() {
        let blackoutView = UIView()
        self.addSubview(blackoutView)
        blackoutView.translatesAutoresizingMaskIntoConstraints = false
        blackoutView.stretch()
        blackoutView.backgroundColor = .black.withAlphaComponent(0.6)
    }
    
    private func setupCenterBlurView() {
        self.addSubview(blurView)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        blurView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        blurView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        blurView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 40).isActive = true
        blurView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -40).isActive = true
        blurView.backgroundColor = .clear
        blurView.layer.masksToBounds = true
        blurView.layer.cornerRadius = 30
        
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        blurView.addSubview(blurEffectView)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.stretch()
    }
    
    private func setupCenterStackView() {
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
        topLabel.text = "Top text"
        topLabel.textAlignment = .natural
        topLabel.font = UIConst.fullScreenTopBottomLabelFont
        topLabel.backgroundColor = .clear
        
        topTextField.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(topTextField)
        topTextField.placeholder = "top_text"
        topTextField.setLeftPaddingPoints(10)
        topTextField.layer.cornerRadius = 10
        topTextField.backgroundColor = .systemGray6
        
        let bottomLabel = UILabel()
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(bottomLabel)
        bottomLabel.text = "Bottom text"
        bottomLabel.font = UIConst.fullScreenTopBottomLabelFont
        bottomLabel.backgroundColor = .clear
        
        bottomTextField.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(bottomTextField)
        bottomTextField.placeholder = "bottom_text"
        bottomTextField.setLeftPaddingPoints(10)
        bottomTextField.layer.cornerRadius = 10
        bottomTextField.backgroundColor = .systemGray6
    }
    
    private func setupGenerateButton() {
        self.addSubview(generateButton)
        generateButton.translatesAutoresizingMaskIntoConstraints = false
        generateButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        generateButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        generateButton.widthAnchor.constraint(equalToConstant: 180).isActive = true
        generateButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        generateButton.layer.masksToBounds = true
        generateButton.layer.cornerRadius = 15
        generateButton.backgroundColor = UIColor(
            red: 123 / 255,
            green: 36 / 255,
            blue: 27 / 255,
            alpha: 1)
        generateButton.setTitle("Generate!", for: .normal)
        generateButton.titleLabel?.font = UIConst.fullScreenTopBottomLabelFont
    }
    
    private func setupSpinnerView() {
        self.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.stretch()
        spinner.isHidden = true
    }
}

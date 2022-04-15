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
    }
    
    func setupFullScreenView() {
        self.addSubview(fullImageView)
        fullImageView.translatesAutoresizingMaskIntoConstraints = false
        fullImageView.stretchSafe()
        fullImageView.contentMode = .scaleAspectFit
        fullImageView.backgroundColor = .blue.withAlphaComponent(0.5)
    }
    
    func setupBlackoutScreen() {
        let blackoutView = UIView()
        self.addSubview(blackoutView)
        blackoutView.translatesAutoresizingMaskIntoConstraints = false
        blackoutView.stretch()
        self.backgroundColor = .darkGray.withAlphaComponent(0.4)
    }
}



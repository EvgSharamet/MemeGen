//
//  LaunchViewController.swift
//  MemeGen
//
//  Created by Евгения Шарамет on 05.05.2022.
//

import Foundation
import UIKit

class SplashViewController: UIViewController {
    public var completionDelegate : (() -> Void)?
    private let image = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupImageView()
        setupLabel()
        setupAnimation()
    }
    
    private func setupLabel() {
        let appLabel = UILabel()
        self.view.addSubview(appLabel)
        appLabel.translatesAutoresizingMaskIntoConstraints = false
        appLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        appLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 140).isActive = true
        appLabel.font = appLabel.font.withSize(59)
        appLabel.text = "MemeGen"
    }
    
    private func setupImageView() {
        self.view.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor.constraint(equalToConstant: 250).isActive = true
        image.widthAnchor.constraint(equalToConstant: 250).isActive = true
        image.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: -20).isActive = true
        image.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "launchDuck")
    }
    
    private func setupAnimation() {
        UIView.animate(withDuration: 4, animations: {
            self.image.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            self.image.transform = CGAffineTransform(translationX: 10, y: 10)
        }) { _ in
            self.completionDelegate?()
        }
    }
}

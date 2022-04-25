//
//  SpinnerView.swift
//  MemeGen
//
//  Created by Евгения Шарамет on 25.04.2022.
//

import Foundation
import UIKit

class SpinnerView: UIView {
    let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    init() {
        super.init(frame: .zero)
        prepare()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func prepare() {
        self.backgroundColor = .darkGray.withAlphaComponent(0.7)
        self.addSubview(spinner)
        
        spinner.startAnimating()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.stretch()
    }
}

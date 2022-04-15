//
//  ImageFullScreen.swift
//  MemeGen
//
//  Created by Евгения Шарамет on 15.04.2022.
//

import Foundation
import UIKit

class ImageFullScreenController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = ImageFullScreenView()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)
        view.stretch()
    }
}

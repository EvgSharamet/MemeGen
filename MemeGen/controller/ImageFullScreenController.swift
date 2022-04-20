//
//  ImageFullScreen.swift
//  MemeGen
//
//  Created by Евгения Шарамет on 15.04.2022.
//

import Foundation
import UIKit

class ImageFullScreenController: UIViewController {
    //MARK: - data
    
    var imageIndex: Int?
    var imageView: UIImageView?
    
    //MARK: - internal functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = ImageFullScreenView()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)
        view.stretch()
        hideKeyboardWhenTappedAround()
        
        self.imageView = view.fullImageView
        
        guard let imageIndex = imageIndex else {
            return
        }
        self.imageView?.image = MemeCollectionRepoService.shared.collection[imageIndex].image
    }
}

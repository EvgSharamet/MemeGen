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
    
    var memeIndex: Int?
    var imageView: UIImageView?
    var topTextField: UITextField?
    var bottomTextField: UITextField?
    var generatBattonTapListener: ((UIImage?) -> Void)?
    
    //MARK: - internal functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = ImageFullScreenView()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)
        view.stretch()
        hideKeyboardWhenTappedAround()
        
        self.imageView = view.fullImageView
        self.topTextField = view.topTextField
        self.bottomTextField = view.bottomTextField
        
        guard let memeIndex = memeIndex else {
            return
        }
        self.imageView?.image = MemeCollectionRepoService.shared.collection[memeIndex].image
        view.generateButton.addTarget(self, action: #selector(generateButtonDidTap), for: .touchUpInside)
    }
    
    @objc private func generateButtonDidTap() {
        guard let index = memeIndex else { return }
        if let top = topTextField?.text, let bottom = bottomTextField?.text {
            let image = ImageCreationService.shared.getMemeWithText(memeName: MemeCollectionRepoService.shared.collection[index].name,
                                                                    topText: top,
                                                                    bottomText: bottom)
            
            generatBattonTapListener?(image)
        }
        
    }
}

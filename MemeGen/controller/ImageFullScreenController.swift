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
    
    private let memeService: IMemeService
    
    //MARK: - public functions
    
    init(memeService: IMemeService) {
        self.memeService = memeService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        view.generateButton.addTarget(self, action: #selector(generateButtonDidTap), for: .touchUpInside)
        
        guard let memeIndex = memeIndex else {
            return
        }

        guard let memeName = self.memeService.memeList?[memeIndex] else {
            return
        }
        
        memeService.getThumbnail(forMeme: memeName) { data in
            switch data {
            case .success(let img):
                DispatchQueue.main.async {
                    self.imageView?.image = img
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc private func generateButtonDidTap() {
        guard let memeIndex = memeIndex else {
            return
        }
        
        guard let memeName = memeService.memeList?[memeIndex] else {
            return
        }
        
        if let top = topTextField?.text, let bottom = bottomTextField?.text {
            memeService.getFullImage(forMeme: memeName, topText: top, bottomText: bottom) { data in
                switch data {
                case .success(let img):
                    DispatchQueue.main.async {
                        self.imageView?.image = img
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

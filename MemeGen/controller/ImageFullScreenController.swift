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
    var spinner: SpinnerView?
    
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
        self.spinner = view.spinner
        
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
    
    //MARK: - private functions
    
    @objc private func generateButtonDidTap() {
        showSpinner()
        guard let memeIndex = memeIndex else {
            return
        }
        
        guard let memeName = memeService.memeList?[memeIndex] else {
            return
        }
        
        if let top = topTextField?.text?.trimmingCharacters(in: .whitespacesAndNewlines),
           let bottom = bottomTextField?.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            memeService.getFullImage(forMeme: memeName, topText: top, bottomText: bottom) { data in
                switch data {
                case .success(let img):
                    DispatchQueue.main.async {
                        self.hideSpinner()
                        self.generatBattonTapListener?(img)
                    }
                    
                case .failure(_):
                    DispatchQueue.main.async {
                        self.hideSpinner()
                        let alert = UIAlertController(title: "Warning", message: "Failed to create meme", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    private func showSpinner() {
        spinner?.isHidden = false
    }
    
    private func hideSpinner() {
        spinner?.isHidden = true
    }
}

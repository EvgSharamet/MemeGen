//
//  SharingViewController.swift
//  MemeGen
//
//  Created by Евгения Шарамет on 15.04.2022.
//

import Foundation
import UIKit

class SharingViewController: UIViewController {
    //MARK: - data
    
    var image: UIImage?
    var popupView: UIView?
    
    //MARK: - internal functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = SharingView()
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.stretch()
        guard let image = self.image else {
            return
        }
        self.popupView = view.popupView
        view.imageView.image = image
        view.saveButton.addTarget(self, action: #selector(saveImage), for: .touchUpInside)
        view.sharingButton.addTarget(self, action: #selector(sharing), for: .touchUpInside)
    }
    
    //MARK: - private functions
    
    @objc private func saveImage() {
        guard let image = image else {
            return
        }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        showPopup()
    }
    
    @objc private func sharing() {
        guard let image = image else {
            return
        }

        let items: [Any] = [image]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
    private func showPopup() {
        UIView.animateKeyframes(withDuration: 1.4, delay: 0) {
            UIView.addKeyframe(withRelativeStartTime: 0 , relativeDuration: 1/7) {
                self.popupView?.alpha = 1
            }
            UIView.addKeyframe(withRelativeStartTime: 6/7, relativeDuration: 1/7) {
                self.popupView?.alpha = 0
            }
        }
    }
}

extension SharingViewController: UIImagePickerControllerDelegate { }

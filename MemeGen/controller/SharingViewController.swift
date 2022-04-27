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
        view.imageView.image = image
        view.saveInLibraryButton.addTarget(self, action: #selector(saveInLibrary), for: .touchUpInside)
    }
    
    @objc private func saveInLibrary() {
        guard let image = image else {
            return
        }

        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}

extension SharingViewController: UIImagePickerControllerDelegate {
}

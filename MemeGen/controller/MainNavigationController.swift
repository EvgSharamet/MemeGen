//
//  MainNavigationController.swift
//  MemeGen
//
//  Created by Евгения Шарамет on 14.04.2022.
//

import Foundation
import UIKit

class MainNavigationController: UINavigationController {
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
        let collectionWindow = ImageCatalogController()
        collectionWindow.cellTapListener = openFullScreen
        pushViewController(collectionWindow, animated: true)
    }
    
    func openFullScreen(_ index: Int) {
        let imageFullWindow = ImageFullScreenController()
        imageFullWindow.memeIndex = index
        imageFullWindow.generatBattonTapListener = openSharingScreen
        pushViewController(imageFullWindow, animated: true)
    }
    
    func openSharingScreen(_ image: UIImage?) {
        let sharingWindow = SharingViewController()
        sharingWindow.image = image
        pushViewController(sharingWindow, animated: true)
    }
}

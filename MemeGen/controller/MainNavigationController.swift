//
//  MainNavigationController.swift
//  MemeGen
//
//  Created by Евгения Шарамет on 14.04.2022.
//

import Foundation
import UIKit

class MainNavigationController: UINavigationController {
    //MARK: - internal functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let collectionWindow = ImageCatalogController()
        collectionWindow.cellTapListener = openFullScreen
        pushViewController(collectionWindow, animated: true)
        
      //  let imageFullWindow = ImageFullScreenController()
      //  pushViewController(imageFullWindow, animated: true)
        
     //   let sharingWindow = SharingViewController()
       // pushViewController(sharingWindow, animated: true)
    }
    
    func openFullScreen(_ index: Int) {
        let imageFullWindow = ImageFullScreenController()
        imageFullWindow.imageIndex = index
        pushViewController(imageFullWindow, animated: true)
    }
}

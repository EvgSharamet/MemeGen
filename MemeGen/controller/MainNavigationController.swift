//
//  MainNavigationController.swift
//  MemeGen
//
//  Created by Евгения Шарамет on 14.04.2022.
//

import Foundation
import UIKit

class MainNavigationController: UINavigationController {
    //MARK: - data
    
    private let memeService: IMemeService
    private let cdService: CoreDataService
    
    //MARK: - public functions
    
    init(memeService: IMemeService, cdService: CoreDataService) {
        self.cdService = cdService
        self.memeService = memeService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - internal functions
    
    override func viewDidLoad() {
        print("viewDidLoad")
        super.viewDidLoad()
        let collectionWindow = ImageCatalogController(memeService: self.memeService, cdService: self.cdService)
        collectionWindow.cellTapListener = openFullScreen
        pushViewController(collectionWindow, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        print("viewDidLayoutSubviews")
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidApear")
        super.viewDidAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        print("viewWillLayoutSubviews")
        super.viewWillLayoutSubviews()
    }
    func openFullScreen(_ index: Int) {
        let imageFullWindow = ImageFullScreenController(memeService: memeService, cdService: cdService)
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

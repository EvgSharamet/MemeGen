//
//  SharingViewController.swift
//  MemeGen
//
//  Created by Евгения Шарамет on 15.04.2022.
//

import Foundation
import UIKit

class SharingViewController: UIViewController {
    //MARK: - internal functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = SharingView()
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.stretch()
    }
}

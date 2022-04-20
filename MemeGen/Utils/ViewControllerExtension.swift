//
//  ViewControllerExtension.swift
//  MemeGen
//
//  Created by Евгения Шарамет on 20.04.2022.
//

import Foundation
import UIKit

extension UIViewController {
    //MARK: - internal functions
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

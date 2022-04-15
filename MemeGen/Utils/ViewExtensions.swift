//
//  ViewExtensions.swift
//  MemeGen
//
//  Created by Евгения Шарамет on 14.04.2022.
//

import Foundation
import UIKit

extension UIView {
    func addSubview(_ subview: UIView, andStretchWithInsets insets: UIEdgeInsets) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.stretch(insets: insets)
    }

    func stretch(inset: CGFloat) {
        stretch(insets: UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset))
    }

    func stretch(insets: UIEdgeInsets = .zero) {
        guard let superview = superview else {
            return
        }
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom)
        ])
    }

    func stretchSafe(inset: CGFloat = 0) {
        guard let superview = superview else {
            return
        }
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: inset),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: inset),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -inset),
            bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: -inset)
        ])
    }
}

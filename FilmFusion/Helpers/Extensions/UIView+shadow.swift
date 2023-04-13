//
//  Extension+shadow.swift
//  AFMovie
//
//  Created by Alex F on 10.04.23.
//

import UIKit

extension UIView {
    func addShadow(_ radius: CGFloat) {
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = 0.5
    }
}

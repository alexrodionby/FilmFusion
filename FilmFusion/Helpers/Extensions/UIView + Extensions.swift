//
//  UIView + Extensions.swift
//  FilmFusion
//
//  Created by Лерочка on 04.04.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
    
    func rotate(angle: CGFloat) {
        let radians = angle
        let rotation = CGAffineTransformRotate(self.transform, radians);
        self.transform = rotation
    }
}


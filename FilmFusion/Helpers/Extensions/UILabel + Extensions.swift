//
//  UILabel + Extensions.swift
//  FilmFusion
//
//  Created by Sergey Azimov on 04.04.2023.
//

import UIKit

extension UILabel {
    
    convenience init(text: String ) {
        self.init()
        self.text = text
        self.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        self.textColor = .customGrayColor
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

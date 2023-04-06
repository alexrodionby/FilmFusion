//
//  UIImageView + Extensions.swift
//  FilmFusion
//
//  Created by Sergey Azimov on 05.04.2023.
//

import UIKit

extension UIImageView {
    
    convenience init(name: String ) {
        self.init()
        self.image = UIImage(named: name)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

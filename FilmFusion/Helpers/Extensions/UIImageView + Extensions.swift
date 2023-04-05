//
//  UIImageView + Extensions.swift
//  FilmFusion
//
//  Created by Sergey Azimov on 05.04.2023.
//

import UIKit

extension UIImageView {
    
    convenience init(systemName: String ) {
        self.init()
        self.image = UIImage(systemName: systemName)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

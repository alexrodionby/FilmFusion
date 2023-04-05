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
        self.tintColor = UIColor(named: "customMiniIcon")
        self.translatesAutoresizingMaskIntoConstraints = false
    }
   
    func makeCircular() {
           self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2.0
           self.clipsToBounds = true
       }
}

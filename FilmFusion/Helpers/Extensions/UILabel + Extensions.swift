//
//  UILabel + Extensions.swift
//  FilmFusion
//
//  Created by Sergey Azimov on 05.04.2023.
//

import UIKit

extension UILabel {
    
    convenience init(text: String) {
        self.init()
        self.text = text
        self.textColor = UIColor(named: "customLabelName")
        self.font = UIFont.PoppinsMedium12()
        self.textColor = .gray
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
    


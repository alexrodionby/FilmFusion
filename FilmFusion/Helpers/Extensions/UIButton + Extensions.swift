//
//  UIButton + Extensions.swift
//  FilmFusion
//
//  Created by KODDER on 12.04.2023.
//

import UIKit

extension UIButton {
    
    convenience init(target: Any?, action: Selector, for: UIControl.Event) {
        self.init()
        self.addTarget(target, action: action, for: .touchUpInside)
        self.setImage(UIImage(named: "uncheck"), for: .normal)
        self.setImage(UIImage(named: "check"), for: .selected)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

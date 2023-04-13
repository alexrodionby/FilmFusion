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
    
    convenience init(forGender: String) {
        self .init()
        self.layer.cornerRadius = 25
        self.layer.borderColor = UIColor(named: "customTabBarIconSelectedTint")?.cgColor
        self.layer.borderWidth = 2
        self.backgroundColor = .none
        self.widthAnchor.constraint(equalToConstant: 160).isActive = true
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}


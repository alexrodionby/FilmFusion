//
//  UITextField + Extensions.swift
//  FilmFusion
//
//  Created by Лерочка on 04.04.2023.
//


import UIKit
extension UITextField {
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:
                                    CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
                                                CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
    
    convenience init(placeholder: String) {
        self.init()
        self.layer.cornerRadius = 25
        self.placeholder = placeholder
        self.layer.borderColor = UIColor(named: "customTabBarIconSelectedTint")?.cgColor
        self.layer.borderWidth = 2
        self.backgroundColor = .none
        self.widthAnchor.constraint(equalToConstant: 335).isActive = true
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.leftView = UIView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: 10,
                                                  height: self.frame.height))
        self.leftViewMode = .always
        self.clearButtonMode = .always
        self.returnKeyType = .done
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    convenience init(customTextField: String = "") {
        self.init()
        self.layer.cornerRadius = 25
        self.layer.borderColor = UIColor(named: "customTabBarIconSelectedTint")?.cgColor
        self.layer.borderWidth = 2
        self.backgroundColor = .none
        self.widthAnchor.constraint(equalToConstant: 335).isActive = true
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.leftView = UIView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: 10,
                                                  height: self.frame.height))
        
        self.leftViewMode = .always
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

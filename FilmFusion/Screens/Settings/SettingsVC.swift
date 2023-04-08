//
//  SettingsVC.swift
//  FilmFusion
//
//  Created by Alexandr Rodionov on 3.04.23.
//

import UIKit

class SettingsVC: UIViewController {
    
    private let logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(named: "customTabBarIconSelectedTint")
        button.tintColor = UIColor.white
        button.setTitle("LogOut", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        button.addTarget(nil, action: #selector(logOutUser), for: .touchUpInside)
        return button
    }()

    
    @objc private func logOutUser() {
        print("Нажали на кнопку логаут")
        Task {
            do {
                try AuthenticationManager.shared.singOut()
                print("Вышли из аккаунта")
            } catch {
                print("Ошибка", error.localizedDescription)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "customBackground")
        
        view.addSubview(logOutButton)

        setupConstraints()
    }

    
    private func setupConstraints() {
        
        logOutButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }

    }

}

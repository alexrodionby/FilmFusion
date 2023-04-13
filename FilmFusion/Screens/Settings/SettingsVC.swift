//
//  SettingsVC.swift
//  FilmFusion
//
//  Created by Alexandr Rodionov on 3.04.23.
//

import UIKit
import SnapKit

class SettingsVC: UIViewController {
    
    var userImage = UIImage(named: "defaultAvatar")
    
    private lazy var userAvatar: UIImageView = {
        let imageView = UIImageView(image: userImage)
        let diameter: CGFloat = 100.0 // желаемый диаметр круга
        let borderWidth: CGFloat = 3.0 // желаемая толщина канта
        imageView.frame.size = CGSize(width: diameter, height: diameter)
        imageView.layer.cornerRadius = diameter / 2.0
        imageView.layer.borderWidth = borderWidth
        imageView.layer.borderColor = UIColor(named: "customTabBarIconSelectedTint")?.cgColor
        imageView.clipsToBounds = true
        imageView.tintColor = UIColor(named: "customCategoryBoard")
        return imageView
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Имя и фамилия"
        label.textColor = UIColor(named: "customLabelName")
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let personalInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Personal Info"
        label.textColor = UIColor(named: "customLabelName")
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let profileLabel: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.textColor = UIColor(named: "customLabelName")
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private lazy var profileIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person"))
        imageView.frame.size = CGSize(width: 30, height: 30)
        imageView.tintColor = UIColor(named: "customLabelName")
        return imageView
    }()
    
    private let securityLabel: UILabel = {
        let label = UILabel()
        label.text = "Security"
        label.textColor = UIColor(named: "customLabelName")
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
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
                let vc = AuthVC()
                if let window = UIApplication.shared.windows.first {
                    window.rootViewController = vc
                    window.makeKeyAndVisible()
                }
            } catch {
                print("Ошибка", error.localizedDescription)
            }
        }
    }
    
    private let resetPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(named: "customTabBarIconSelectedTint")
        button.tintColor = UIColor.white
        button.setTitle("Reset password", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        button.addTarget(nil, action: #selector(resetPass), for: .touchUpInside)
        return button
    }()
    
    @objc private func resetPass() {
        print("Нажали на кнопку сброса пароля")
        Task {
            do {
                let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
                guard let email = authUser.email else {
                    throw URLError(.fileDoesNotExist)
                }
                try await AuthenticationManager.shared.resetPassword(email: email)
                print("Сделали ресет пароля")
            } catch {
                print("Ошибка", error.localizedDescription)
            }
        }
    }
    
    private let updatePasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(named: "customTabBarIconSelectedTint")
        button.tintColor = UIColor.white
        button.setTitle("Update password", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        button.addTarget(nil, action: #selector(updatePass), for: .touchUpInside)
        return button
    }()
    
    @objc private func updatePass() {
        print("Нажали на кнопку обновления пароля")
        Task {
            do {
                try await AuthenticationManager.shared.updatePassword(password: passwordUpdateTextField.text ?? "none")
                print("Сделали апдейт пароля")
                passwordUpdateTextField.text = ""
            } catch {
                print("Ошибка", error.localizedDescription)
            }
        }
    }
    
    private let updateEmailButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(named: "customTabBarIconSelectedTint")
        button.tintColor = UIColor.white
        button.setTitle("Update email", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        button.addTarget(nil, action: #selector(updateEmail), for: .touchUpInside)
        return button
    }()
    
    @objc private func updateEmail() {
        print("Нажали на кнопку обновления почты")
        Task {
            do {
                try await AuthenticationManager.shared.updateEmail(email: emailUpdateTextField.text ?? "none")
                print("Сделали апдейт почты")
                emailUpdateTextField.text = ""
            } catch {
                print("Ошибка", error.localizedDescription)
            }
        }
    }
    
    private lazy var passwordUpdateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter new password"
        textField.backgroundColor = UIColor(named: "customCategoryBoard")
        textField.delegate = self
        textField.returnKeyType = .done
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        let image = UIImage(systemName: "eye.slash.fill")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        textField.rightView = imageView
        textField.rightViewMode = .always
        textField.rightView?.tintColor = UIColor(named: "customMiniLabel")
        return textField
    }()
    
    private lazy var emailUpdateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter new email"
        textField.backgroundColor = UIColor(named: "customCategoryBoard")
        textField.delegate = self
        textField.returnKeyType = .done
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "customBackground")
        navigationItem.title = "Settings"
        
        view.addSubview(userAvatar)
        view.addSubview(userNameLabel)
        view.addSubview(personalInfoLabel)
        view.addSubview(profileIcon)
        view.addSubview(profileLabel)
        view.addSubview(securityLabel)
        
        view.addSubview(logOutButton)
        view.addSubview(resetPasswordButton)
        view.addSubview(updatePasswordButton)
        view.addSubview(passwordUpdateTextField)
        view.addSubview(updateEmailButton)
        view.addSubview(emailUpdateTextField)
        
        setupConstraints()
    }
    
    
    private func setupConstraints() {
        
        userAvatar.snp.makeConstraints {
            $0.top.equalTo(view.snp.topMargin).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.height.width.equalTo(100)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(view.snp.topMargin).offset(30)
            $0.leading.equalTo(userAvatar.snp.trailing).offset(20)
            $0.height.equalTo(30)
        }
        
        personalInfoLabel.snp.makeConstraints {
            $0.top.equalTo(userAvatar.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
        }
        
        profileIcon.snp.makeConstraints {
            $0.top.equalTo(personalInfoLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.height.width.equalTo(30)
        }
        
        profileLabel.snp.makeConstraints {
            $0.centerY.equalTo(profileIcon.snp.centerY)
            $0.leading.equalTo(profileIcon.snp.trailing).offset(10)
        }
        
        securityLabel.snp.makeConstraints {
            $0.top.equalTo(profileIcon.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
        }
        
        logOutButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        resetPasswordButton.snp.makeConstraints {
            $0.top.equalTo(logOutButton.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        updatePasswordButton.snp.makeConstraints {
            $0.top.equalTo(resetPasswordButton.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        passwordUpdateTextField.snp.makeConstraints {
            $0.top.equalTo(resetPasswordButton.snp.bottom).offset(20)
            $0.leading.equalTo(updatePasswordButton.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        updateEmailButton.snp.makeConstraints {
            $0.top.equalTo(passwordUpdateTextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        emailUpdateTextField.snp.makeConstraints {
            $0.top.equalTo(passwordUpdateTextField.snp.bottom).offset(20)
            $0.leading.equalTo(updateEmailButton.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
    }
    
}

extension SettingsVC: UITextFieldDelegate  {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//
//  LoginWithEmailVC.swift
//  FilmFusion
//
//  Created by Alexandr Rodionov on 5.04.23.
//

import UIKit

class LoginWithEmailVC: UIViewController {
    
    var email = ""
    var pass = ""
    
    private var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "e-mail"
        textField.backgroundColor = .none
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor(named: "customTabBarIconSelectedTint")?.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    
    private var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "password"
        textField.backgroundColor = .none
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor(named: "customTabBarIconSelectedTint")?.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(named: "customTabBarIconSelectedTint")
        button.tintColor = UIColor.white
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        button.addTarget(nil, action: #selector(loginUser), for: .touchUpInside)
        return button
    }()
    
    @objc private func loginUser() {
        Task {
            print("Нажали на кнопку логин")
            email = emailTextField.text ?? ""
            pass = passwordTextField.text ?? ""
            print(email, pass)
            do {
                try await signIn()
                navigationController?.pushViewController(TabBarVC(), animated: true)
            } catch {
                print("Ошибка", error.localizedDescription)
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func signIn() async throws {
        guard !email.isEmpty, !pass.isEmpty else {
            print("Не ввели логин или пароль")
            return
        }
        do {
            let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: pass)
            print("Удалось создать пользователя")
            print(returnedUserData)
        } catch {
            print("Ошибка создания пользователя", error.localizedDescription)
        }
        
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "customBackground")
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        emailTextField.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
        }
        
    }
    
}

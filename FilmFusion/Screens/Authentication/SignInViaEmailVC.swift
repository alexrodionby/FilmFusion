//
//  SignInViaEmailVC.swift
//  FilmFusion
//
//  Created by Alexandr Rodionov on 9.04.23.
//

import UIKit
import SnapKit

class SignInViaEmailVC: UIViewController {
    
    private var emailUser: String = ""
    private var passwordUser: String = ""
    
    private let loginAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Login to your account"
        label.textColor = UIColor(named: "customLabelName")
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.textColor = UIColor(named: "customMiniLabel")
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your email"
        textField.backgroundColor = UIColor(named: "customCategoryBoard")
        textField.delegate = self
        textField.returnKeyType = .done
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.textColor = UIColor(named: "customMiniLabel")
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your password"
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
    
    private let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(named: "customTabBarIconSelectedTint")
        button.tintColor = UIColor.white
        button.setTitle("Sign In", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
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
        print("Нажали Sign In")
        Task {
            do {
                try await signIn()
                navigationController?.pushViewController(TabBarVC(), animated: true)
            } catch {
                print("Ошибка", error.localizedDescription)
            }
        }
    }
    
    @objc private func signIn() async throws {
        emailUser = emailTextField.text ?? "None"
        passwordUser = passwordTextField.text ?? "None"
        print("Логин, пароль =", emailUser, passwordUser)
        guard emailUser != "None", passwordUser != "None" else {
            print("Не ввели логин или пароль")
            return
        }
        do {
            let returnedUserData = try await AuthenticationManager.shared.signInUser(email: emailUser, password: passwordUser)
            print("Удалось войти под логином и паролем")
            print(returnedUserData)
            RealmDataBase.shared.createUserWith(uuid: returnedUserData.uid, firstName: "", lastName: "", email: returnedUserData.email!)
            let vc = TabBarVC()
            if let window = UIApplication.shared.windows.first {
                window.rootViewController = vc
                window.makeKeyAndVisible()
            }
        } catch {
            print("Ошибка входа по логину и паролю", error.localizedDescription)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        navigationItem.title = "Login"
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "customBackground")
        view.addSubview(loginAccountLabel)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
    }
    
    private func setupConstraints() {
        loginAccountLabel.snp.makeConstraints {
            $0.top.equalTo(view.snp.topMargin).offset(10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(30)
        }
        
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(loginAccountLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(45)
        }
        
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(45)
        }
        
        signInButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(50)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
    

}

extension SignInViaEmailVC: UITextFieldDelegate  {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

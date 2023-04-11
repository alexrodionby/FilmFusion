//
//  CreateUserViaEmailVC.swift
//  FilmFusion
//
//  Created by Alexandr Rodionov on 9.04.23.
//

import UIKit
import SnapKit

class CreateUserViaEmailVC: UIViewController {
    
    var emailUser: String = ""
    private var passwordUser: String = ""
    private var passwordUserConfirm: String = ""
    
    private let completAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Complet your account"
        label.textColor = UIColor(named: "customLabelName")
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private lazy var firstNameLabel: UILabel = {
        let label = UILabel()
        label.text = "First Name"
        label.textColor = UIColor(named: "customMiniLabel")
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private lazy var firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your First Name"
        textField.backgroundColor = UIColor(named: "customCategoryBoard")
        textField.delegate = self
        textField.returnKeyType = .done
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private lazy var lastNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Last Name"
        label.textColor = UIColor(named: "customMiniLabel")
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private lazy var lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your Last Name"
        textField.backgroundColor = UIColor(named: "customCategoryBoard")
        textField.delegate = self
        textField.returnKeyType = .done
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "E-mail"
        label.textColor = UIColor(named: "customMiniLabel")
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your E-mail"
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
    
    private lazy var confirmPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Confirm Password"
        label.textColor = UIColor(named: "customMiniLabel")
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private lazy var confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Confirm your password"
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

    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(named: "customTabBarIconSelectedTint")
        button.tintColor = UIColor.white
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        button.addTarget(nil, action: #selector(createUser), for: .touchUpInside)
        return button
    }()
    
    @objc private func createUser() {
        print("Нажали Sign Up")
        Task {
            do {
                try await signUp()
                navigationController?.pushViewController(TabBarVC(), animated: true)
            } catch {
                print("Ошибка", error.localizedDescription)
            }
        }
    }
    
    @objc private func signUp() async throws {
        emailUser = emailTextField.text ?? "None"
        passwordUser = passwordTextField.text ?? "None"
        passwordUserConfirm = confirmPasswordTextField.text ?? "None"
        print("Логин, пароль, контроль =", emailUser, passwordUser, passwordUserConfirm)
        guard emailUser != "None", passwordUser != "None", passwordUser == passwordUserConfirm else {
            print("Не ввели логин или пароль, или пароли не совпадают")
            return
        }
        do {
            let returnedUserData = try await AuthenticationManager.shared.createUser(email: emailUser, password: passwordUser)
//            RealmDataBase.shared.createUserWith(uuid: returnedUserData.uid, firstName: <#T##String#>, lastName: <#T##String#>, email: <#T##String#>, dateOfBirth: <#T##String#>, gender: <#T##String#>, profilePicture: <#T##Data#>)
            print("Удалось создать пользователя")
            print(returnedUserData)
        } catch {
            print("Ошибка создания пользователя", error.localizedDescription)
        }
    }
    
    private lazy var haveAnAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Already have an account?"
        label.textColor = UIColor(named: "customMiniLabel")
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        button.addTarget(nil, action: #selector(loginTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func loginTapped() {
        print("Нажали Login")
        let vc = SignInViaEmailVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        navigationItem.title = "Sign Up"
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "arrow.backward.circle.fill")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.backward.circle.fill")
        navigationController?.navigationBar.tintColor = UIColor(named: "customMiniLabel")

    }

    private func setupView() {
        view.backgroundColor = UIColor(named: "customBackground")
        view.addSubview(completAccountLabel)
        view.addSubview(firstNameLabel)
        view.addSubview(firstNameTextField)
        view.addSubview(lastNameLabel)
        view.addSubview(lastNameTextField)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(confirmPasswordLabel)
        view.addSubview(confirmPasswordTextField)
        view.addSubview(signUpButton)
        view.addSubview(haveAnAccountLabel)
        view.addSubview(loginButton)
        emailTextField.text = emailUser
    }
    
    private func setupConstraints() {
        
        completAccountLabel.snp.makeConstraints {
            $0.top.equalTo(view.snp.topMargin).offset(10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(30)
        }
        
        firstNameLabel.snp.makeConstraints {
            $0.top.equalTo(completAccountLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
        }
        
        firstNameTextField.snp.makeConstraints {
            $0.top.equalTo(firstNameLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(45)
        }
        
        lastNameLabel.snp.makeConstraints {
            $0.top.equalTo(firstNameTextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        lastNameTextField.snp.makeConstraints {
            $0.top.equalTo(lastNameLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(45)
        }
        
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(lastNameTextField.snp.bottom).offset(20)
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
        
        confirmPasswordLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        confirmPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(confirmPasswordLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(45)
        }
        
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(confirmPasswordTextField.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(50)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        let size = haveAnAccountLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: haveAnAccountLabel.frame.height))
        let width = size.width
        
        haveAnAccountLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-50)
            $0.centerX.equalToSuperview().offset(-30)
        }
        
        loginButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-50)
            $0.leading.equalToSuperview().offset(width + 90)
            $0.height.equalTo(size.height)
        }
        
        
    }

}


extension CreateUserViaEmailVC: UITextFieldDelegate  {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

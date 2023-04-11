//
//  AuthVC.swift
//  FilmFusion
//
//  Created by Alexandr Rodionov on 5.04.23.
//

import UIKit
import SnapKit

class AuthVC: UIViewController {
    
    private lazy var bottomView: UIView = {
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor(named: "customBackground")
        bottomView.layer.cornerRadius = 30
        bottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return bottomView
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(named: "customTabBarIconSelectedTint")
        button.tintColor = UIColor.white
        button.setTitle("Continue with Email", for: .normal)
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
    
    private let createAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Create account"
        label.textColor = .white
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
        textField.placeholder = "Enter your email address"
        textField.backgroundColor = UIColor(named: "customCategoryBoard")
        textField.delegate = self
        textField.returnKeyType = .done
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private lazy var orContinueWithLabel: UILabel = {
        let label = UILabel()
        label.text = "\u{2014}\u{2014}\u{2014}\u{2014}\u{2014}\u{2014} Or continue with \u{2014}\u{2014}\u{2014}\u{2014}\u{2014}\u{2014}"
        label.textColor = UIColor(named: "customMiniLabel")
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
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
      //  navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @objc private func createUser() {
        print("Нажали Continue with Email")
        let vc = CreateUserViaEmailVC()
        vc.emailUser = emailTextField.text ?? ""
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        view.backgroundColor = UIColor(named: "customTabBarIconSelectedTint")
        view.addSubview(createAccountLabel)
        view.addSubview(bottomView)
        bottomView.addSubview(emailLabel)
        bottomView.addSubview(emailTextField)
        bottomView.addSubview(signUpButton)
        bottomView.addSubview(orContinueWithLabel)
        bottomView.addSubview(haveAnAccountLabel)
        bottomView.addSubview(loginButton)
    }
    
    private func setupConstraints() {
        
        bottomView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(view.frame.height / 3)
            $0.leading.bottom.trailing.equalToSuperview()
        }
        
        createAccountLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(100)
        }
        
        emailLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.equalToSuperview().offset(20)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(45)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(50)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        orContinueWithLabel.snp.makeConstraints {
            $0.top.equalTo(signUpButton.snp.bottom).offset(50)
            $0.height.equalTo(30)
            $0.centerX.equalToSuperview()
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

extension AuthVC: UITextFieldDelegate  {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

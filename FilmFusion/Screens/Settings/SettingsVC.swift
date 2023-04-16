//
//  SettingsVC.swift
//  FilmFusion
//
//  Created by Alexandr Rodionov on 3.04.23.
//

import UIKit
import SnapKit
import Realm

class SettingsVC: UIViewController {
    
    var userImage = UIImage(named: "defaultAvatar")

    private lazy var userAvatar: UIImageView = {
        let imageView = UIImageView(image: userImage)
        if let image = UIImage(data: RealmDataBase.shared.currentRealmUser.profilePicture) {
            imageView.image = image
        }
        let diameter: CGFloat = 100.0
        let borderWidth: CGFloat = 3.0
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
        label.text = "\(RealmDataBase.shared.currentRealmUser.firstname) \(RealmDataBase.shared.currentRealmUser.lastName)"
        label.textColor = UIColor(named: "customLabelName")
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let userEmailLabel: UILabel = {
        let label = UILabel()
        label.text = RealmDataBase.shared.currentRealmUser.email
        label.textColor = UIColor(named: "customMiniLabel")
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
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
    
    private let profileButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        button.setBackgroundImage(UIImage(systemName: "arrow.right.circle"), for: .normal)
        button.tintColor = UIColor(named: "customTabBarIconSelectedTint")
        button.addTarget(nil, action: #selector(editProfile), for: .touchUpInside)
        return button
    }()
    
    @objc func editProfile() {
        self.handleProfileButton()
    }
    
    func handleProfileButton() {
        print("Нажали редактировать аккаунт")
        navigationController?.pushViewController(EditingViewController(), animated: true)
    }
    
    private let securityLabel: UILabel = {
        let label = UILabel()
        label.text = "Security"
        label.textColor = UIColor(named: "customLabelName")
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private lazy var changePasswordIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "lock"))
        imageView.frame.size = CGSize(width: 30, height: 30)
        imageView.tintColor = UIColor(named: "customLabelName")
        return imageView
    }()
    
    private let changePasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Change password", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(UIColor(named: "customLabelName"), for: .normal)
        button.addTarget(nil, action: #selector(changePasswordAlert), for: .touchUpInside)
        return button
    }()
    
    @objc func changePasswordAlert() {
        let alertController = UIAlertController(title: "Change password?", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Enter new password"
            textField.isSecureTextEntry = true
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okayAction = UIAlertAction(title: "Okay", style: .default) { _ in
            if let textField = alertController.textFields?.first, let text = textField.text {
                self.handleChangePassword(text)
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okayAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func handleChangePassword(_ text: String) {
        print("Нажали окей", text)
        Task {
            do {
                try await AuthenticationManager.shared.updatePassword(password: text)
                print("Сделали апдейт пароля")
            } catch {
                print("Ошибка", error.localizedDescription)
            }
        }
    }
    
    private lazy var resetPasswordIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "lock.open"))
        imageView.frame.size = CGSize(width: 30, height: 30)
        imageView.tintColor = UIColor(named: "customLabelName")
        return imageView
    }()
    
    private let resetPasswordButtonNew: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset password", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(UIColor(named: "customLabelName"), for: .normal)
        button.addTarget(nil, action: #selector(resetPasswordAlert), for: .touchUpInside)
        return button
    }()
    
    @objc func resetPasswordAlert() {
        let alertController = UIAlertController(title: "Reset password?", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okayAction = UIAlertAction(title: "Okay", style: .default) {_ in
            self.handleResetPassword()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okayAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func handleResetPassword() {
        print("Нажали сброс пароля")
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
    
    private lazy var changeEmailIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "mail"))
        imageView.frame.size = CGSize(width: 30, height: 30)
        imageView.tintColor = UIColor(named: "customLabelName")
        return imageView
    }()
    
    private let changeEmailButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Change email", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(UIColor(named: "customLabelName"), for: .normal)
        button.addTarget(nil, action: #selector(changeEmailAlert), for: .touchUpInside)
        return button
    }()
    
    @objc func changeEmailAlert() {
        let alertController = UIAlertController(title: "Change email?", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Enter new email"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okayAction = UIAlertAction(title: "Okay", style: .default) { _ in
            if let textField = alertController.textFields?.first, let text = textField.text {
                self.handleChangeEmail(text)
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okayAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func handleChangeEmail(_ text: String) {
        print("Нажали окей", text)
        Task {
            do {
                try await AuthenticationManager.shared.updateEmail(email: text)
                print("Сделали апдейт почты")
            } catch {
                print("Ошибка", error.localizedDescription)
            }
        }
    }
    
    private lazy var logoutButtonIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "escape"))
        imageView.frame.size = CGSize(width: 30, height: 30)
        imageView.tintColor = UIColor(named: "customLabelName")
        return imageView
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("LogOut", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(UIColor(named: "customLabelName"), for: .normal)
        button.addTarget(nil, action: #selector(logoutButtonAlert), for: .touchUpInside)
        return button
    }()
    
    @objc func logoutButtonAlert() {
        let alertController = UIAlertController(title: "Logout?", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okayAction = UIAlertAction(title: "Okay", style: .default) {_ in
            self.handleLogoutButton()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okayAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func handleLogoutButton() {
        print("Нажали выход из аккаунта")
        Task {
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
    }
    
    private lazy var themeIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "switch.2"))
        imageView.frame.size = CGSize(width: 30, height: 30)
        imageView.tintColor = UIColor(named: "customLabelName")
        return imageView
    }()
    
    private let themeLabel: UILabel = {
        let label = UILabel()
        label.text = "Dark Mode"
        label.textColor = UIColor(named: "customLabelName")
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let themeSwitch: UISwitch = {
        let mySwitch = UISwitch()
        mySwitch.backgroundColor = UIColor(named: "customBackground")
        mySwitch.onTintColor = UIColor(named: "customTabBarIconSelectedTint")
        mySwitch.tintColor = UIColor(named: "customMiniLabel")
        mySwitch.isOn = false
        mySwitch.addTarget(nil, action: #selector(didSwitchTheme), for: .valueChanged)
        return mySwitch
    }()
    
    @objc private func didSwitchTheme() {
        if themeSwitch.isOn {
            let window = UIApplication.shared.windows.first
            window?.overrideUserInterfaceStyle = .dark
        } else {
            let window = UIApplication.shared.windows.first
            window?.overrideUserInterfaceStyle = .light
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
            
    }
    
    override func viewWillAppear(_ animated: Bool) {
    updateUserData()
    }
     func updateUserData(){
        if let image = UIImage(data: RealmDataBase.shared.currentRealmUser.profilePicture) {
            userAvatar.image = image
        }
         userNameLabel.text = "\(RealmDataBase.shared.currentRealmUser.firstname)  \(RealmDataBase.shared.currentRealmUser.lastName )"
         userEmailLabel.text = RealmDataBase.shared.currentRealmUser.email
         
    }
    private func setupView() {
        view.backgroundColor = UIColor(named: "customBackground")
        navigationItem.title = "Settings"
        
        view.addSubview(userAvatar)
        view.addSubview(userNameLabel)
        view.addSubview(userEmailLabel)
        view.addSubview(personalInfoLabel)
        view.addSubview(profileIcon)
        view.addSubview(profileLabel)
        view.addSubview(profileButton)
        view.addSubview(securityLabel)
        view.addSubview(changePasswordIcon)
        view.addSubview(changePasswordButton)
        view.addSubview(resetPasswordIcon)
        view.addSubview(resetPasswordButtonNew)
        view.addSubview(changeEmailIcon)
        view.addSubview(changeEmailButton)
        view.addSubview(logoutButtonIcon)
        view.addSubview(logoutButton)
        view.addSubview(themeIcon)
        view.addSubview(themeLabel)
        view.addSubview(themeSwitch)
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
        
        userEmailLabel.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom).offset(10)
            $0.leading.equalTo(userAvatar.snp.trailing).offset(20)
            $0.height.equalTo(20)
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
        
        profileButton.snp.makeConstraints {
            $0.centerY.equalTo(profileLabel.snp.centerY)
            $0.trailing.equalToSuperview().offset(-30)
            $0.height.width.equalTo(30)
        }
        
        securityLabel.snp.makeConstraints {
            $0.top.equalTo(profileIcon.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
        }
        
        changePasswordIcon.snp.makeConstraints {
            $0.top.equalTo(securityLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(25)
        }
        
        changePasswordButton.snp.makeConstraints {
            $0.centerY.equalTo(changePasswordIcon.snp.centerY)
            $0.leading.equalTo(changePasswordIcon.snp.trailing).offset(20)
        }
        
        resetPasswordIcon.snp.makeConstraints {
            $0.centerX.equalTo(changePasswordIcon.snp.centerX)
            $0.top.equalTo(changePasswordIcon.snp.bottom).offset(20)
        }
        
        resetPasswordButtonNew.snp.makeConstraints {
            $0.centerY.equalTo(resetPasswordIcon.snp.centerY)
            $0.leading.equalTo(resetPasswordIcon.snp.trailing).offset(20)
        }
        
        changeEmailIcon.snp.makeConstraints {
            $0.centerX.equalTo(resetPasswordIcon.snp.centerX)
            $0.top.equalTo(resetPasswordIcon.snp.bottom).offset(20)
        }
        
        changeEmailButton.snp.makeConstraints {
            $0.centerY.equalTo(changeEmailIcon.snp.centerY)
            $0.leading.equalTo(changeEmailIcon.snp.trailing).offset(20)
        }
        
        logoutButtonIcon.snp.makeConstraints {
            $0.centerX.equalTo(changeEmailIcon.snp.centerX)
            $0.top.equalTo(changeEmailIcon.snp.bottom).offset(20)
        }
        
        logoutButton.snp.makeConstraints {
            $0.centerY.equalTo(logoutButtonIcon.snp.centerY)
            $0.leading.equalTo(logoutButtonIcon.snp.trailing).offset(20)
        }
        
        themeIcon.snp.makeConstraints {
            $0.centerX.equalTo(logoutButtonIcon.snp.centerX)
            $0.top.equalTo(logoutButtonIcon.snp.bottom).offset(20)
        }
        
        themeLabel.snp.makeConstraints {
            $0.centerY.equalTo(themeIcon.snp.centerY)
            $0.leading.equalTo(themeIcon.snp.trailing).offset(20)
        }
        
        themeSwitch.snp.makeConstraints {
            $0.centerY.equalTo(themeIcon.snp.centerY)
            $0.trailing.equalToSuperview().offset(-30)
        }
    }
}

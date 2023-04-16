//
//  MainView.swift
//  FilmFusion
//
//  Created by KODDER on 13.04.2023.
//

import UIKit

class MainView: UIView {
    
    var delegate: ImagePickerProtocol?
    
    private let scrollView = UIScrollView()
     private let avatarHeight: CGFloat = 120
    
    lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "defaultUser")

        if let image = UIImage(data: RealmDataBase.shared.currentRealmUser.profilePicture) {
            imageView.image = image
        }
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = avatarHeight / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let editImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Edit")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let firstNameLabel = UILabel(textTextFields: "First Name")
    private let firstNameTextField = UITextField(placeholder: "First Name")
    var firstNameStackView = UIStackView()
    
    private let lastNameLabel = UILabel(textTextFields: "Last Name")
    private let lastNameTextField = UITextField(placeholder: "Last Name")
    var lastNameStackView = UIStackView()
    
    private let emailLabel = UILabel(textTextFields: "E-mail")
    private let emailTextField = UITextField(placeholder: "E-mail")
    var emailStackView = UIStackView()
    
    private let dateLabel = UILabel(textTextFields: "Date of Birth")
    private let dateTextField = UITextField(customTextField: "Date")
    private let dateImageView = UIImageView(name: "Calendar")
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .automatic
        datePicker.tintColor = UIColor(named: "customTabBarIconSelectedTint")
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    var dateStackView = UIStackView()
    
    private let genderLabel = UILabel(textTextFields: "Gender")
    private let maleView = UIView(forGender: "Male")
    private lazy var maleButton = UIButton(target: self,
                                           action: #selector(selectGenre),
                                           for: .valueChanged)
    private let maleLabel = UILabel(textTextFields: "Male")
    var maleStackView = UIStackView()
    
    private let femaleView = UIView(forGender: "Female")
    private lazy var femaleButton = UIButton(target: self,
                                             action: #selector(selectGenre),
                                             for: .valueChanged)
    private let femaleLabel = UILabel(textTextFields: "Female")
    var femaleStackView = UIStackView()
    var maleFemaleStackView = UIStackView()
    var genderStackView = UIStackView()
    
    private let locationLabel = UILabel(textTextFields: "Location")
    private var locationTextView: UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = 25
        textView.layer.borderColor = UIColor(named: "customTabBarIconSelectedTint")?.cgColor
        textView.layer.borderWidth = 2
        textView.backgroundColor = .none
        textView.inputView = UIView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: 10,
                                                  height: textView.frame.height))
        textView.widthAnchor.constraint(equalToConstant: 335).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    var locationStackView = UIStackView()
    
    private lazy var saveButton: UIButton = {
            let button = UIButton(type: .system)
            button.backgroundColor = UIColor(named: "customTabBarIconSelectedTint")
            button.tintColor = UIColor.white
            button.setTitle("Save Changes", for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
            button.layer.cornerRadius = 25
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
            return button
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraints()
    }
    
    private func setupView() {
        setGesture()
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        
        
        scrollView.addSubview(userImageView)
        scrollView.addSubview(editImageView)

        firstNameStackView = UIStackView(arrangedSubviews: [firstNameLabel, firstNameTextField],
                                         axis: .vertical,
                                         spacing: 10)
        scrollView.addSubview(firstNameStackView)

        lastNameStackView = UIStackView(arrangedSubviews: [lastNameLabel, lastNameTextField],
                                        axis: .vertical,
                                        spacing: 10)
        scrollView.addSubview(lastNameStackView)
        
        emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField],
                                     axis: .vertical,
                                     spacing: 10)
        scrollView.addSubview(emailStackView)
        
        dateStackView = UIStackView(arrangedSubviews: [dateLabel, dateTextField],
                                    axis: .vertical,
                                    spacing: 10)
        dateTextField.addSubview(dateImageView)
        dateTextField.addSubview(datePicker)
        scrollView.addSubview(dateStackView)
        
        maleFemaleStackView = UIStackView(arrangedSubviews: [maleView, femaleView],
                                          axis: .horizontal,
                                          spacing: 15)
        maleFemaleStackView.distribution = .fillEqually
        maleStackView = UIStackView(arrangedSubviews: [maleButton, maleLabel],
                                    axis: .horizontal,
                                    spacing: 15)
        maleView.addSubview(maleStackView)
        femaleStackView = UIStackView(arrangedSubviews: [femaleButton, femaleLabel],
                                      axis: .horizontal,
                                      spacing: 15)
        femaleView.addSubview(femaleStackView)
        genderStackView = UIStackView(arrangedSubviews: [genderLabel, maleFemaleStackView],
                                      axis: .vertical,
                                      spacing: 10)
        scrollView.addSubview(genderStackView)
        
        locationStackView = UIStackView(arrangedSubviews: [locationLabel, locationTextView],
                                        axis: .vertical,
                                        spacing: 10)
        scrollView.addSubview(locationStackView)
        scrollView.addSubview(saveButton)
    }
    
    @objc private func selectGenre(_ sender: UIButton) {
        if sender == maleButton {
            maleButton.isSelected = true
            femaleButton.isSelected = false
        } else {
            maleButton.isSelected = false
            femaleButton.isSelected = true
        }
    }
    
    //RealmDataBase.shared.currentRealmUser.firstname
    
    @objc private func didTap() {
        RealmDataBase.shared.updateUserDataWith(uuid:RealmDataBase.shared.currentRealmUser.uuid ,
                                                firstName: firstNameTextField.text ?? "noName",
                                                lastName: lastNameTextField.text ?? "",
                                                email: emailTextField.text ?? "",
                                                dateOfBirth: "",
                                                gender: "",
                                                profilePicture: userImageView.image?.jpegData(compressionQuality: 0.6) ?? Data())
        print("Save profile")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            userImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            userImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            
            userImageView.heightAnchor.constraint(equalToConstant: avatarHeight),
            userImageView.widthAnchor.constraint(equalToConstant: avatarHeight),
            

            editImageView.centerXAnchor.constraint(equalTo: userImageView.centerXAnchor, constant: 40),
            editImageView.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor, constant: 35),

            firstNameStackView.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 20),
            firstNameStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),

            lastNameStackView.topAnchor.constraint(equalTo: firstNameStackView.bottomAnchor, constant: 15),
            lastNameStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            
            emailStackView.topAnchor.constraint(equalTo: lastNameStackView.bottomAnchor, constant: 15),
            emailStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            
            dateStackView.topAnchor.constraint(equalTo: emailStackView.bottomAnchor, constant: 15),
            dateStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            dateImageView.trailingAnchor.constraint(equalTo: dateTextField.trailingAnchor, constant: -20),
            dateImageView.centerYAnchor.constraint(equalTo: dateTextField.centerYAnchor),
            datePicker.leadingAnchor.constraint(equalTo: dateTextField.leadingAnchor, constant: 15),
            datePicker.centerYAnchor.constraint(equalTo: dateTextField.centerYAnchor),
            
            genderStackView.topAnchor.constraint(equalTo: dateStackView.bottomAnchor, constant: 15),
            genderStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            genderStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            
            maleStackView.centerYAnchor.constraint(equalTo: maleView.centerYAnchor),
            maleStackView.leadingAnchor.constraint(equalTo: maleView.leadingAnchor, constant: 10),
            femaleStackView.centerYAnchor.constraint(equalTo: femaleView.centerYAnchor),
            femaleStackView.leadingAnchor.constraint(equalTo: femaleView.leadingAnchor, constant: 10),
            
            locationStackView.topAnchor.constraint(equalTo: genderStackView.bottomAnchor, constant: 15),
            locationStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            
            saveButton.topAnchor.constraint(equalTo: locationStackView.bottomAnchor, constant: 60),
            saveButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 60),
            saveButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -100),
        ])
    }
}
// MARK: - image picker
extension MainView {
    func setGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        editImageView.isUserInteractionEnabled = true
        editImageView.addGestureRecognizer(gesture)

    }
    
    @objc func selectImage() {
        print("taptap edit ava")
        self.delegate?.showImagePicker()
    }
    
    func updateImage(with image: UIImage) {
        userImageView.image = image
    }
}

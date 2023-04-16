//
//  EditingViewController.swift
//  FilmFusion
//
//  Created by KODDER on 12.04.2023.
//

import UIKit

protocol ImagePickerProtocol {
    func showImagePicker()
}

class EditingViewController: UIViewController, ImagePickerProtocol {
    
    private let mainView = MainView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "customBackground")
        
        view.addSubview(mainView)
        mainView.delegate = self
    }
}

extension EditingViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
// MARK: - imagePicker
extension EditingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func showImagePicker() {
        print("show in VC")
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = .photoLibrary
        imagePickerVC.delegate = self
        self.present(imagePickerVC, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return  }
        mainView.updateImage(with: image)
//        RealmDataBase.shared.updateUserDataWith(uuid: cu, firstName: <#T##String#>, lastName: <#T##String#>, email: <#T##String#>, dateOfBirth: <#T##String#>, gender: <#T##String#>, profilePicture: <#T##Data#>)
        dismiss(animated: true)
    }
    
    
    
    
}

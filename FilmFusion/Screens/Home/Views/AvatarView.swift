//
//  AvatarView.swift
//  AFMovie
//
//  Created by Alex F on 5.04.23.
//

import UIKit
import SnapKit
class AvatarView: UIView {
    let avatarHeight: CGFloat = 46
    
    let someView = UIView()
    lazy var imageView: UIImageView = {
        let iView = UIImageView()
        iView.contentMode = .scaleAspectFill
        iView.clipsToBounds = true
        iView.image = UIImage(named: "avatar")
        iView.layer.cornerRadius = avatarHeight / 2
        iView.layer.borderWidth = 1
        iView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor

        return iView
    }()
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Hi, dear User"
        return label
        }()
    var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Run Forrest run"
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .gray
        return label
        }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        self.addSubview(nameLabel)
        self.addSubview(subTitleLabel)
        setupConstraints()
        
        updateUserdata()

    }
    func updateUserdata() {
        nameLabel.text = "Hi, \(RealmDataBase.shared.currentRealmUser.firstname) \(RealmDataBase.shared.currentRealmUser.lastName)"
        subTitleLabel.text = RealmDataBase.shared.currentRealmUser.email
        imageView.image = UIImage(named: "defaultUser")
        if let image = UIImage(data: RealmDataBase.shared.currentRealmUser.profilePicture) {
                  imageView.image = image
              }
        
        
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.width.equalTo(avatarHeight)
            make.height.equalTo(avatarHeight)
            make.leading.equalTo(self).offset(28)
            make.top.equalToSuperview().offset(3)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView)
            make.left.equalTo(imageView.snp.right).offset(16)
        }
        subTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(imageView.snp.bottom).offset(-2)
            make.left.equalTo(nameLabel)
        }
    }

}

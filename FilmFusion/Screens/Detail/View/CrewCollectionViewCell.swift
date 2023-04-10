//
//  CollectionViewCell.swift
//  FilmFusion
//
//  Created by Sergey Azimov on 06.04.2023.
//

import UIKit

class CrewCollectionViewCell: UICollectionViewCell {
    
    private let PhotoCastImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "luck-movie")
        
        imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let fullNameCastLabel: UILabel = {
        let label = UILabel()
        label.text = "Ivan Ivanov"
        label.font = UIFont.PlusJakartaSansMedium14()
        label.textColor = UIColor(named: "customLabelName")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let jobTitleCastLabel: UILabel = {
        let label = UILabel()
        label.text = "President of whole galaxy"
        label.font = UIFont.PlusJakartaSansMedium10()
        label.textColor = UIColor(named: "customMiniLabel")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setup Views
    private func setupViews() {
        addSubview(PhotoCastImage)
        addSubview(fullNameCastLabel)
        addSubview(jobTitleCastLabel)
    }
    
}

//MARK: - setConstraints
extension CrewCollectionViewCell {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            
            PhotoCastImage.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            PhotoCastImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            
            PhotoCastImage.heightAnchor.constraint(equalToConstant: 40),
            PhotoCastImage.widthAnchor.constraint(equalToConstant: 40),
            
            
            fullNameCastLabel.leadingAnchor.constraint(equalTo: PhotoCastImage.trailingAnchor, constant: 5),
            fullNameCastLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            
            jobTitleCastLabel.topAnchor.constraint(equalTo: fullNameCastLabel.bottomAnchor),
            jobTitleCastLabel.leadingAnchor.constraint(equalTo: PhotoCastImage.trailingAnchor, constant: 5),
            
            
            
        ])
    }
    
}

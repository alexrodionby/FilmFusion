//
//  CardsCell.swift
//  AFMovie
//
//  Created by Alex Fount on 6.04.23.
//

import UIKit
class CardCell: UICollectionViewCell {
    
    static let reuseId = "CardCell"
     let imageView = UIImageView()

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
        fatalError("init(coder:) has not been implemented!")
    }
    
    func setupView() {
        imageView.image =  UIImage(named: "film")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        addSubview(imageView)
        
        setupConstraints()
        
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.5
    }
    func configure(with film: Film) {
        imageView.image = film.poster
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

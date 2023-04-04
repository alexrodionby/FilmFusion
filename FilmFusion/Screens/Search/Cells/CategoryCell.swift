//
//  CategoryCell.swift
//  FilmFusion
//
//  Created by Лерочка on 04.04.2023.
//

import UIKit

final class CategoryCell: UICollectionViewCell {
    
    static let identifier = "CategoryCell"

    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
//        label.textColor = UIColor(named: "unselectedCategory")!
        label.textColor = .white
        return label
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    public func configure(with title: String) {
        categoryLabel.text = title
    }
    
    private func setupViews() {
        contentView.addSubview(categoryLabel)
    }
    
    private func setupConstraints() {
        categoryLabel.textAlignment = .center
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: topAnchor),
            categoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}


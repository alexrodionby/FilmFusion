//
//  CategoryCell.swift
//  AFMovie
//
//  Created by Alex Fount on 6.04.23.
//

import UIKit
class CategoriesCell: UICollectionViewCell {
    static let reuseId = "CategoryCell"
    
    override var isSelected: Bool {
        didSet {
            ovalView.backgroundColor = isSelected ? UIColor(named: "customTabBarIconSelectedTint") : .clear
            titleLabel.textColor = isSelected ? .white : UIColor(named: "customLabelName")
        }
    }
    
    lazy var  ovalView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 17
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "emptyuCategory"
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
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
        
        self.addSubview(ovalView)
        self.addSubview(titleLabel)
        
        setupConstraints()
    }
    
   func  setupConstraints() {
       titleLabel.snp.makeConstraints { make in
           make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20))
       }
       
       ovalView.snp.makeConstraints { make in
           make.edges.equalToSuperview()
       }

    }
    
    func configure(with category: Category) {
        titleLabel.text = category.title
        print("cat cell configured")
    }
    
    
}

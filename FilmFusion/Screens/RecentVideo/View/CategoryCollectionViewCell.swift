//
//  CategoryCollectionViewCell.swift
//  FilmFusion
//
//  Created by Ян Бойко on 09.04.2023.
//

import UIKit
import SnapKit

class CatgoryCell: UICollectionViewCell {
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private let categoryLabel: UILabel = {
        let view = UILabel()
        view.text = ""
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = UIColor(named: "customCategoryTextUnselected")
        return view
    }()

    func configure(text: String) {
        categoryLabel.text = text
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                categoryLabel.textColor = .white
                self.contentView.backgroundColor = UIColor(hexString: "514EB6")
                contentView.layer.borderColor = UIColor(hexString: "514EB6").cgColor
            } else {
                categoryLabel.textColor = UIColor(named: "customCategoryTextUnselected")
                self.contentView.backgroundColor = UIColor(named: "customBackground")
                contentView.layer.borderColor = UIColor(named: "customCategoryBoard")?.cgColor
            }
        }
    }



    private func setupView() {
        contentView.backgroundColor = UIColor(named: "customBackground")
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(named: "customCategoryBoard")?.cgColor
        contentView.layer.cornerRadius = 20
        contentView.addSubview(categoryLabel)
        setupConstraints()
    }

    private func setupConstraints() {
        categoryLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            //make.leading.trailing.equalToSuperview().inset(5)
        }
    }
}

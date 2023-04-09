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
        view.text = "хуй"
        return view
    }()

    func configure(text: String) {
        categoryLabel.text = text
    }



    private func setupView() {
        contentView.backgroundColor = .systemPink
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

//
//  FilmTableViewCell.swift
//  FilmFusion
//
//  Created by Ян Бойко on 04.04.2023.
//

import UIKit
import SnapKit
import Kingfisher

protocol FilmTableViewCellDelegate: AnyObject {
    func didTapFavoriteButton(onCell cell: FilmTableViewCell)
}

final class FilmTableViewCell: UITableViewCell {
    
    weak var delegate: FilmTableViewCellDelegate?
        
    static let identifier = "FilmCell"
    
    private let pictureImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "luck-movie")
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Luck"
        view.numberOfLines = 2
        view.textColor = UIColor(named: "customLabelName")
        view.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return view
    }()
    
    private let timeImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "clock")
        return view
    }()
    
    private let timeLabel: UILabel = {
        let view = UILabel()
        view.text = "148 Minutes"
        view.textColor = UIColor(named: "customMiniLabel")
        view.font = UIFont.systemFont(ofSize: 14)
        return view
    }()
    
    private let calendarImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "calendar")
        return view
    }()
    
    private let calendarLabel: UILabel = {
        let view = UILabel()
        view.text = "17 Sep 2021"
        view.textColor = UIColor(named: "customMiniLabel")
        view.font = UIFont.systemFont(ofSize: 14)
        return view
    }()
    
    private let filmImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "film")
        return view
    }()
    
    private let categoryView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "514EB6")
        view.layer.cornerRadius = 6
        return view
    }()
    
    private let categoryLabel: UILabel = {
        let view = UILabel()
        view.text = "Action"
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return view
    }()
    
    private let starImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "star.fill")
        view.tintColor = UIColor(hexString: "FACC15")
        return view
    }()
    
    private let raitingLabel: UILabel = {
        let view = UILabel()
        view.text = "4.4"
        view.textColor = UIColor(hexString: "FACC15")
        view.font = UIFont.systemFont(ofSize: 14)
        return view
    }()
    
    private let reviewsLabel: UILabel = {
        let view = UILabel()
        view.text = "(52)"
        view.textColor = UIColor(named: "customMiniLabel")
        view.font = UIFont.systemFont(ofSize: 14)
        return view
    }()
    
    private let favImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "heart")
        view.tintColor = UIColor(named: "customMiniLabel")
        return view
    }()
    
    private let favButton: UIButton = {
        let view = UIButton()
        view.addTarget(nil, action: #selector(favButtonTapped), for: .touchUpInside)
        return view
    }()

    var isSaved: Bool = false {
        didSet {
            favImageView.image = isSaved ?
            UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            favImageView.tintColor = isSaved ?
            UIColor(hexString: "514EB6") : UIColor(named: "customMiniLabel")
            print("isSaved: \(self.isSaved)")
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    @objc func favButtonTapped() {
        print("Кнопка избранное нажалась")
        if isSaved {
            RealmDataBase.shared.deleteItem(withName: titleLabel.text!)
        } else {
            let newFilm = RealmFilm()
            newFilm.titleName = titleLabel.text!
            newFilm.image = (pictureImageView.image?.pngData()!)!
            newFilm.releaseDate = calendarLabel.text!
            newFilm.voteAverage = Double(raitingLabel.text!)!
            newFilm.voteCount = Int(reviewsLabel.text!)!
            RealmDataBase.shared.write(favoritesRealmFilm: newFilm)
        }
        delegate?.didTapFavoriteButton(onCell: self)
        isSaved.toggle()
    }
    
    
    func configure(with model: MovieViewModel) {
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.posterURL)") else { return }
        pictureImageView.kf.setImage(with: url)
        titleLabel.text = model.titleName
        calendarLabel.text = model.releaseDate
        raitingLabel.text = "\(model.voteAverage)"
        reviewsLabel.text = "\(model.voteCount)"
//        timeLabel.text = "\(model.runtime)"
        isSaved = RealmDataBase.shared.isItemSaved(withName: titleLabel.text!)
    }
    
    func configureWithRealm(film: RealmFilm) {
        pictureImageView.image = UIImage(data: film.image)
        titleLabel.text = film.titleName
        calendarLabel.text = film.releaseDate
        raitingLabel.text = "\(film.voteAverage)"
        reviewsLabel.text = "\(film.voteCount)"
//        isSaved = true
        isSaved = RealmDataBase.shared.isItemSaved(withName: film.titleName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - Setup View
    
    private func setupView() {
        backgroundColor = UIColor(named: "customBackground")
        contentView.addSubview(pictureImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(timeImageView)
        contentView.addSubview(timeLabel)
        contentView.addSubview(calendarImageView)
        contentView.addSubview(calendarLabel)
        contentView.addSubview(filmImageView)
        contentView.addSubview(categoryView)
        categoryView.addSubview(categoryLabel)
        contentView.addSubview(starImageView)
        contentView.addSubview(raitingLabel)
        contentView.addSubview(reviewsLabel)
        contentView.addSubview(favButton)
        favButton.addSubview(favImageView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        pictureImageView.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalTo(pictureImageView.snp.trailing).offset(15)
            make.trailing.equalToSuperview().inset(55)
        }
        
        timeImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(13)
            make.leading.equalTo(pictureImageView.snp.trailing).offset(15)
            make.height.width.equalTo(16)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(13)
            make.leading.equalTo(timeImageView.snp.trailing).offset(5)
        }
        
        calendarImageView.snp.makeConstraints { make in
            make.top.equalTo(timeImageView.snp.bottom).offset(13)
            make.leading.equalTo(pictureImageView.snp.trailing).offset(15)
            make.height.width.equalTo(16)
        }
        
        calendarLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(13)
            make.leading.equalTo(calendarImageView.snp.trailing).offset(5)
        }
        
        filmImageView.snp.makeConstraints { make in
            make.top.equalTo(calendarImageView.snp.bottom).offset(13)
            make.leading.equalTo(pictureImageView.snp.trailing).offset(15)
            make.height.width.equalTo(16)
        }
        
        categoryView.snp.makeConstraints { make in
            make.top.equalTo(calendarLabel.snp.bottom).offset(8)
            make.leading.equalTo(filmImageView.snp.trailing).offset(5)
            make.height.equalTo(24)
            make.width.equalTo(65)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        starImageView.snp.makeConstraints { make in
            make.top.equalTo(filmImageView.snp.bottom).offset(13)
            make.bottom.lessThanOrEqualToSuperview().inset(10)
            make.leading.equalTo(pictureImageView.snp.trailing).offset(15)
            make.height.width.equalTo(16)
        }
        
        raitingLabel.snp.makeConstraints { make in
            make.top.equalTo(filmImageView.snp.bottom).offset(13)
            make.bottom.lessThanOrEqualToSuperview().inset(10)
            make.leading.equalTo(starImageView.snp.trailing).offset(5)
        }
        
        reviewsLabel.snp.makeConstraints { make in
            make.top.equalTo(filmImageView.snp.bottom).offset(13)
            make.bottom.lessThanOrEqualToSuperview().inset(10)
            make.leading.equalTo(raitingLabel.snp.trailing).offset(5)
        }
        
        favButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(20)
        }
        
        favImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.width.equalTo(24)
        }
    }
}

//
//  FilmCell.swift
//  AFMovie
//
//  Created by Alex Fount on 9.04.23.
//

import UIKit
import Kingfisher
import SnapKit

protocol FilmCellDelegate: AnyObject {
    func didTapFavoriteButton()
}

class FilmCell: UITableViewCell {
    
    static let reuseId = "FilmCell"
    
    weak var delegate: FilmCellDelegate?
    
    var date: String = "11"
    var voteAverage: Double = 11.1
    var voteCount: Int = 11
    
    var posterView: UIImageView = {
        let postView = UIImageView()
        postView.contentMode = .scaleAspectFill
        postView.layer.cornerRadius = 16
        postView.clipsToBounds = true
        postView.image = UIImage(named: "film")
        postView.translatesAutoresizingMaskIntoConstraints = false
        return postView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "The conchas utjyjrfasel"
        return label
    }()
    
    var genreLabel: UILabel = {
        let label = UILabel()
        label.text = "Genre"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    var runtimeLabel: UILabel = UILabel()
    
    var isSaved: Bool = false {
        didSet {
            favoriteLabel.image = isSaved ?
            UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            favoriteLabel.tintColor = isSaved ?
            UIColor(hexString: "514EB6") : UIColor(named: "customMiniLabel")
            print("isSaved: \(self.isSaved)")
        }
        
    }
    
    
    lazy var favoriteLabel: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: (isSaved ? "heart.fill" : "heart"))
        view.tintColor = isSaved ? UIColor.orange : UIColor.gray
        view.image = UIImage(systemName: "heart")
        view.tintColor = UIColor.gray
        
        return view
    }()
    
    var votesLabel: UILabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String? ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        runtimeLabel.addClockBefore(by: 15)
        votesLabel.addVotes(average: 2.0, 33)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func favTapped() {
        print("Кнопка SSS нажалась")
        if isSaved {
            RealmDataBase.shared.deleteItem(withName: titleLabel.text!)
        } else {
            let newFilm = RealmFilm()
            newFilm.titleName = titleLabel.text!
            newFilm.image = (posterView.image?.pngData()!)!
            newFilm.releaseDate = date
            newFilm.voteAverage = voteAverage
            newFilm.voteCount = voteCount
            
            RealmDataBase.shared.write(favoritesRealmFilm: newFilm)
        }
        delegate?.didTapFavoriteButton()
        isSaved.toggle()
    }
    
    func setupTapView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(favTapped))
        self.favoriteLabel.isUserInteractionEnabled = true
        self.favoriteLabel.addGestureRecognizer(tap)
    }
    
    func setupCell() {
        
        self.contentView.addSubview(posterView)
        self.contentView.addSubview(genreLabel)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(runtimeLabel)
        self.contentView.addSubview(votesLabel)
        self.contentView.addSubview(favoriteLabel)
        
        self.backgroundColor = UIColor(named: "customBackground")
        setupTapView()
        setupConstraints()
        posterView.layer.shadowOffset = CGSize(width: 2, height: 2)
        posterView.layer.shadowColor = UIColor.black.cgColor
        posterView.layer.shadowRadius = 10
        posterView.layer.shadowOpacity = 0.5
        
    }
    func configure(with movie: Movie) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.unwrappedPosterPath)") else { return }
        posterView.kf.setImage(with: url)
        titleLabel.text = movie.unwrappedOriginalTitle
        // runtimeLabel.addClockBefore(by: movie.unwrappedRuntime)
        runtimeLabel.addClockBefore(by: Int.random(in: 110..<149))
        votesLabel.addVotes(average: movie.unwrappedVoteAverage, movie.unwrappedVoteCount)
        //genreLabel.text = movie.unwrappedGenres[0].name
        date = movie.release_date!
        voteCount = movie.vote_count
        voteAverage = movie.vote_average
        
        let categoryTemp = ["Action", "Adventure", "Animation", "Comedy", "Crime", "Documentary", "Drama", "Family", "Fantasy", "History", "Horror", "Music", "Mystery", "Romance", "Science Fiction", "TV Movie", "Thriller", "War", "Western"]
        
        genreLabel.text = categoryTemp.randomElement()
        
        isSaved = RealmDataBase.shared.isItemSaved(withName: titleLabel.text!)
        
        print(movie.id)
    }
    
    
    
    func setupConstraints() {
        posterView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(25)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterView.snp.trailing).offset(16)
            make.centerY.equalToSuperview().offset(-6)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.bottom.equalTo(titleLabel.snp.top).offset(-4)
        }
        
        runtimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.bottom.equalTo(posterView).offset(-6)
        }
        
        favoriteLabel.snp.makeConstraints { make in
            make.top.equalTo(posterView)
            make.trailing.equalTo(self.snp.trailing).offset(-25)
        }
        
        votesLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.trailing).offset(-86)
            make.bottom.equalTo(runtimeLabel)
        }
        
    }
    
}
// MARK: - UILabel extentions

extension UILabel {
    func addClockBefore(by runTime: Int){
        let text = " \(runTime) min"
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "clock.fill")?.withTintColor(.gray)
        let imageString = NSMutableAttributedString(attachment: attachment)
        let textString = NSAttributedString(string: text)
        imageString.append(textString)
        
        self.attributedText = imageString
        self.textColor = .gray
        self.font = UIFont.systemFont(ofSize: 14, weight: .light)
        
    }
}

extension UILabel {
    func addVotes(average vote: Double, _ totalVotes: Int) {
        let textVotes = "\(vote)"
        let textAllVotes = "(\(totalVotes))"
        
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "star.fill")?  .withTintColor(.orange)
        attachment.bounds = CGRect(x:0, y: -1, width: 13, height: 13)
        
        let imageString = NSMutableAttributedString(attachment: attachment)
        
        let attributeOrrange = [ NSAttributedString.Key.foregroundColor: UIColor.orange]
        let attributeGray = [ NSAttributedString.Key.foregroundColor: UIColor.gray]
        
        let attrStringVotes = NSAttributedString(string: textVotes, attributes: attributeOrrange)
        let attrStringAllVotes = NSAttributedString(string: textAllVotes, attributes: attributeGray)
        let attrStringSpace = NSAttributedString(string: " ")
        
        imageString.append(attrStringSpace)
        imageString.append(attrStringVotes)
        imageString.append(attrStringAllVotes)
        
        self.attributedText = imageString
        self.font = UIFont.systemFont(ofSize: 14, weight: .light)
    }
}

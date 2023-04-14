//
//  FilmCell.swift
//  AFMovie
//
//  Created by Alex Fount on 9.04.23.
//

import UIKit
import Kingfisher

class FilmCell: UITableViewCell {
    
    static let reuseId = "FilmCell"
    
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
        label.text = "Action"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    var runtimeLabel: UILabel = UILabel()
    
    var favoriteLabel: UIImageView = {
        let isFavorite: Bool = false
        let view = UIImageView()
        view.image = UIImage(systemName: (isFavorite ? "heart.fill" : "heart"))
        view.tintColor = isFavorite ? UIColor.orange : UIColor.gray
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
    
    func setupCell() {
        self.contentView.addSubview(posterView)
        self.contentView.addSubview(genreLabel)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(runtimeLabel)
        self.contentView.addSubview(favoriteLabel)
        self.contentView.addSubview(votesLabel)
        self.backgroundColor = UIColor(named: "customBackground")
        
        setupConstraints()
        posterView.layer.shadowOffset = CGSize(width: 2, height: 2)
        posterView.layer.shadowColor = UIColor.black.cgColor
        posterView.layer.shadowRadius = 10
        posterView.layer.shadowOpacity = 0.5
        
        
    }
    func configure(with movie: Movie) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.unwrappedPosterPath)") else { return }
        posterView.kf.setImage(with: url)
        titleLabel.text = movie.title
        runtimeLabel.addClockBefore(by: movie.unwrappedRuntime)
        votesLabel.addVotes(average: movie.unwrappedVoteAverage, movie.unwrappedVoteCount)
        //genreLabel.text = movie.unwrappedGenres[0].name
        
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
        //label.textColor = .gray
        self.font = UIFont.systemFont(ofSize: 14, weight: .light)
    }
}

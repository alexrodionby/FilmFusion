//
//  DetailVC.swift
//  FilmFusion
//
//  Created by Sergey Azimov on 05.04.2023.
//

import UIKit
import Kingfisher
import WebKit
class DetailVC: UIViewController {
        
    let additionalInfo = DetailView()
    let discrpitionView = DescriptionView()
    let castCollection = CastView()

//    let presentTrailer = PresentTrailer()

    
    private var voteCount = 0
    private var voteAverage: Double = 0.0
    private var randomRunTime = Int.random(in: 110...190)
    
    private lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = view.bounds
        scrollView.contentSize = contentSize
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.frame.size = contentSize
        contentView.backgroundColor = UIColor(named: "customBackground")
        return contentView
    }()
    
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    
    private let posterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "luck-movie")
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let posterTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Movie name"
        label.font = UIFont.PlusJakartaSansBold24()
        label.textColor = UIColor(named: "customLabelName")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let rateStarsView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let castAndCrewTitle: UILabel = {
        let label = UILabel()
        label.text = "Cast and Crew"
        label.font = UIFont.PlusJakartaSansBold16()
        label.textColor = UIColor(named: "customLabelName")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let watchButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(named: "customTabBarIconSelectedTint")
        button.titleLabel?.font = UIFont.PlusJakartaSansBold16()
        button.tintColor = .white
        button.setTitle("Watch now", for: .normal)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func addStarsToRateView() {
        
        let numberOfStars = 5
        for _ in 1...numberOfStars {
            let starImage:UIImageView = {
                let imageView = UIImageView()
                
                imageView.image = UIImage(named: "star-fill")
                imageView.tintColor = .yellow
                return imageView
            }()
            rateStarsView.addArrangedSubview(starImage)
        }
    }
    //counting and showing average vote
    func fillStarStackViewWithRating(averageRating: Double, starStackView: UIStackView) {
        let ratingOutOfFive = averageRating / 2.0
        let fullStarCount = Int(ratingOutOfFive)
        let halfStarCount = Int((ratingOutOfFive - Double(fullStarCount)) * 2)
        let emptyStarCount = 5 - fullStarCount - halfStarCount
        
        for (index, subview) in starStackView.arrangedSubviews.enumerated() {
            if let imageView = subview as? UIImageView {
                if index < fullStarCount {
                    imageView.image = UIImage(named: "star-fill")
                } else if index < fullStarCount + halfStarCount {
                    imageView.image = UIImage(named: "star-half")
                } else {
                    imageView.image = UIImage(named: "star-empty")
                }
            }
        }
    }
    
    
    var isSaved: Bool = false {
        didSet {
            navigationItem.rightBarButtonItem?.image = isSaved ?
            UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            navigationItem.rightBarButtonItem?.tintColor = isSaved ?
            UIColor(hexString: "514EB6") : UIColor(named: "customMiniLabel")
        }
    }
    
    func configure(with model: DetailMovieViewModel ) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.posterURL)") else { return }
        posterImage.kf.setImage(with: url)
        posterTitle.text = model.titleName
        additionalInfo.dataReleaseLabel.text = model.releaseDate
        additionalInfo.runTimeLabel.text = "\(randomRunTime) munites"
        discrpitionView.storyLineTextView.text = model.overview
        voteAverage = model.voteAverage
        isSaved = RealmDataBase.shared.isItemSaved(withName: posterTitle.text!)
    }
    
    func configureWithRealm(film: RealmFilm) {
        posterImage.image = UIImage(data: film.image)
        posterTitle.text = film.titleName
        additionalInfo.dataReleaseLabel.text = film.releaseDate
        additionalInfo.runTimeLabel.text = String(film.runtime)
        discrpitionView.storyLineTextView.text = film.filmDescription
        voteAverage = film.voteAverage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(voteAverage) оценка и \(voteCount) голосов")
        tabBarController?.tabBar.isHidden = true
        watchButton.addTarget(self, action: #selector(watchButtonTapped), for: .touchUpInside)
        view.backgroundColor = UIColor(named: "customBackground")
        title = "Movie Detail"
        setupViews()
        setConstraints()
        setupNavBar()
        addStarsToRateView()
        fillStarStackViewWithRating(averageRating: voteAverage, starStackView: rateStarsView)
        isMovieFavorite()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        let newFilm = RealmFilm()
//        newFilm.titleName = posterTitle.text!
//        newFilm.image = (posterImage.image?.pngData()!)!
//        newFilm.releaseDate = additionalInfo.dataReleaseLabel.text!
//        newFilm.filmDescription = discrpitionView.storyLineTextView.text!
//        newFilm.voteAverage = voteAverage
//        newFilm.voteCount = voteCount
//        RealmDataBase.shared.write(recentWatchRealmFilm: newFilm)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isToolbarHidden = true
        tabBarController?.tabBar.isHidden = false
        let newFilm = RealmFilm()
        newFilm.titleName = posterTitle.text!
        newFilm.image = (posterImage.image?.pngData()!)!
        newFilm.releaseDate = additionalInfo.dataReleaseLabel.text!
        newFilm.filmDescription = discrpitionView.storyLineTextView.text!
        newFilm.voteAverage = voteAverage
        newFilm.voteCount = voteCount
        RealmDataBase.shared.write(recentWatchRealmFilm: newFilm)
    }
    
    private func setupNavBar() {
        navigationItem.leftBarButtonItem =  UIBarButtonItem(image: UIImage(systemName: "arrow.left.circle"), style: .plain, target: self, action: #selector(tappedbackButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .done, target: self, action: #selector(tappedHeart))
        navigationController?.navigationBar.tintColor = UIColor(named: "customMiniIcon")
        
    }
    
    func isMovieFavorite() {
        navigationItem.rightBarButtonItem?.image = RealmDataBase.shared.isItemSaved(withName: posterTitle.text!) ?
        UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        navigationItem.rightBarButtonItem?.tintColor =  RealmDataBase.shared.isItemSaved(withName: posterTitle.text!) ?
        UIColor(hexString: "514EB6") : UIColor(named: "customMiniLabel")
    }
    
    @objc  func watchButtonTapped(_ sender: UIButton) {
            print("watchButton нажалась")
        }
    
    @objc func tappedbackButton() {
        self.dismiss(animated: true,completion: nil)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc private func tappedHeart() {
        print("Кнопка избранное нажалась в detailVC")
        if isSaved {
            RealmDataBase.shared.deleteItem(withName: posterTitle.text!)
        } else {
            let newFilm = RealmFilm()
            newFilm.titleName = posterTitle.text!
            newFilm.image = (posterImage.image?.pngData()!)!
            newFilm.releaseDate = additionalInfo.dataReleaseLabel.text!
            newFilm.voteAverage = voteAverage
            newFilm.voteCount = voteCount
            newFilm.filmDescription = discrpitionView.storyLineTextView.text!
            RealmDataBase.shared.write(favoritesRealmFilm: newFilm)
        }
        isSaved.toggle()
        
    }
    //MARK: - setup Views
    private func setupViews() {
        view.addSubviews(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(posterImage)
        contentView.addSubview(posterTitle)
        contentView.addSubviews(additionalInfo)
        contentView.addSubviews(rateStarsView)
        contentView.addSubview(discrpitionView)
        contentView.addSubview(castAndCrewTitle)
        contentView.addSubview(castCollection)
        contentView.addSubview(watchButton)
    }
}
//MARK: - setConstraints
extension DetailVC {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            
            posterImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20),
            posterImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            posterImage.widthAnchor.constraint(equalToConstant: 220),
            posterImage.heightAnchor.constraint(equalToConstant: 300),
            
            posterTitle.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 10),
            posterTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            posterTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            posterTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            additionalInfo.topAnchor.constraint(equalTo: posterTitle.bottomAnchor, constant: 15),
            additionalInfo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            additionalInfo.widthAnchor.constraint(equalToConstant: 280),
            additionalInfo.heightAnchor.constraint(equalToConstant: 30),
            
            rateStarsView.topAnchor.constraint(equalTo: additionalInfo.bottomAnchor, constant: 15),
            rateStarsView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            rateStarsView.widthAnchor.constraint(equalToConstant: 100),
            rateStarsView.heightAnchor.constraint(equalToConstant: 16),
            
            discrpitionView.topAnchor.constraint(equalTo: rateStarsView.bottomAnchor, constant: 20),
            discrpitionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            discrpitionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

            
            castAndCrewTitle.topAnchor.constraint(equalTo: discrpitionView.bottomAnchor, constant: 10),
            castAndCrewTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            castCollection.topAnchor.constraint(equalTo: castAndCrewTitle.bottomAnchor, constant: 15 ),
            castCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            castCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            castCollection.heightAnchor.constraint(equalToConstant: 50),
    
            watchButton.widthAnchor.constraint(equalToConstant: 180),
            watchButton.heightAnchor.constraint(equalToConstant: 55),
            watchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            watchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            
        ])
    }
}



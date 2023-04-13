//
//  DetailVC.swift
//  FilmFusion
//
//  Created by Sergey Azimov on 05.04.2023.
//

import UIKit
import Kingfisher
class DetailVC: UIViewController {
    
    let additionalInfo = DetailView()
    let discrpitionView = DescriptionView()
    let castCollection = CastView()
    
    var voteCount = 0
    var voteAverage: Double = 0.0
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
        CGSize(width: view.frame.width, height: view.frame.height - 50 )
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
    
//    private let toolBarWatchButton: UIView = {
//       let view = UIView()
//        view.backgroundColor = .systemGroupedBackground
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
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
        additionalInfo.runTimeLabel.text = "\(model.runtime)"
        discrpitionView.storyLineTextView.text = model.overview
        voteAverage = model.voteAverage
        isSaved = RealmDataBase.shared.isItemSaved(withName: posterTitle.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isToolbarHidden = false
        tabBarController?.tabBar.isHidden = true
        tabBarController?.navigationController?.isNavigationBarHidden = true
        watchButton.addTarget(self, action: #selector(watchButtonTapped), for: .touchUpInside)
        view.backgroundColor = UIColor(named: "customBackground")
        title = "Movie Detail"
        setupViews()
        setConstraints()
        setupNavBar()
        addStarsToRateView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let newFilm = RealmFilm()
        newFilm.titleName = posterTitle.text!
        newFilm.image = (posterImage.image?.pngData()!)!
        newFilm.releaseDate = additionalInfo.dataReleaseLabel.text!
        newFilm.voteAverage = voteAverage
        newFilm.voteCount = voteCount
        RealmDataBase.shared.write(recentWatchRealmFilm: newFilm)
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    private func setupNavBar() {
        
        navigationItem.leftBarButtonItem =  UIBarButtonItem(image: UIImage(systemName: "arrow.left.circle"), style: .plain, target: self, action: #selector(tappedbackButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .done, target: self, action: #selector(tappedHeart))
        navigationController?.navigationBar.tintColor = UIColor(named: "customMiniIcon")
        
    }
    
    @objc  func watchButtonTapped(_ sender: UIButton) {
     
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
            RealmDataBase.shared.write(favoritesRealmFilm: newFilm)
        }
        isSaved.toggle()
        
    }
    //MARK: - setup Views
    private func setupViews() {
    navigationController?.toolbar.addSubview(watchButton)
        view.addSubviews(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(posterImage)
        contentView.addSubview(posterTitle)
        contentView.addSubviews(additionalInfo)
        contentView.addSubviews(rateStarsView)
        contentView.addSubview(discrpitionView)
        contentView.addSubview(castAndCrewTitle)
        contentView.addSubview(castCollection)
       // view.addSubview(toolBarWatchButton)
       // toolBarWatchButton.addSubview(watchButton)
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
            discrpitionView.heightAnchor.constraint(equalToConstant: 200),
            
            castAndCrewTitle.topAnchor.constraint(equalTo: discrpitionView.bottomAnchor, constant: 10),
            castAndCrewTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            castCollection.topAnchor.constraint(equalTo: castAndCrewTitle.bottomAnchor, constant: 15 ),
            castCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            castCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            castCollection.heightAnchor.constraint(equalToConstant: 50),
            
            //toolBarWatchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            //toolBarWatchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            //toolBarWatchButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            //toolBarWatchButton.heightAnchor.constraint(equalToConstant: 100),
            
            navigationController!.toolbar.heightAnchor.constraint(equalToConstant: 100),
            
            watchButton.topAnchor.constraint(equalTo: navigationController!.toolbar.topAnchor, constant: 5),
            watchButton.centerXAnchor.constraint(equalTo: navigationController!.toolbar.centerXAnchor),
            
            watchButton.widthAnchor.constraint(equalToConstant: 180),
            watchButton.heightAnchor.constraint(equalToConstant: 55),
            
        ])
    }
}



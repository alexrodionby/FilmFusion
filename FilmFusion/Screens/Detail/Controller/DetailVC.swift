//
//  DetailVC.swift
//  FilmFusion
//
//  Created by Sergey Azimov on 05.04.2023.
//

import UIKit

class DetailVC: UIViewController {
    
    let additionalInfo = DetailView()
    let DiscrpitionView = DescriptionView()
    let castCollection = CastView()
    
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
        imageView.backgroundColor = .green
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        watchButton.addTarget(self, action: #selector(watchButtonTapped), for: .touchUpInside)
        view.backgroundColor = UIColor(named: "customBackground")
        title = "Movie Detail"
        setupViews()
        setConstraints()
        setupNavBar()
        addStarsToRateView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        addNewRecentWatch()
    }
    
    func addNewRecentWatch() {
        let newFilm = RealmFilm()
        newFilm.titleName = posterTitle.text!
        newFilm.image = (posterImage.image?.pngData()!)!
        newFilm.releaseDate = additionalInfo.dataReleaseLabel.text!
        RealmDataBase.shared.write(recentWatchRealmFilm: newFilm)
    }
    
    private func setupNavBar() {
        navigationController?.isToolbarHidden = false
        navigationItem.leftBarButtonItem =  UIBarButtonItem(image: UIImage(systemName: "arrow.left.circle"), style: .done, target: self, action: #selector(tappedbackButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .done, target: self, action: #selector(tappedHeart))
        navigationController?.navigationBar.tintColor = UIColor(named: "customMiniIcon")
        
    }
    
    @objc  func watchButtonTapped(_ sender: UIButton) {
        print("watch-button tapped")
    }
    
    @objc private func tappedbackButton() {
        print("Back to main")
    }
    
    @objc private func tappedHeart() {
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
        contentView.addSubview(DiscrpitionView)
        contentView.addSubview(castAndCrewTitle)
        contentView.addSubview(castCollection)
        
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
            
            DiscrpitionView.topAnchor.constraint(equalTo: rateStarsView.bottomAnchor, constant: 20),
            DiscrpitionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            DiscrpitionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            DiscrpitionView.heightAnchor.constraint(equalToConstant: 200),
            
            castAndCrewTitle.topAnchor.constraint(equalTo: DiscrpitionView.bottomAnchor, constant: 10),
            castAndCrewTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            castCollection.topAnchor.constraint(equalTo: castAndCrewTitle.bottomAnchor, constant: 15 ),
            castCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            castCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            castCollection.heightAnchor.constraint(equalToConstant: 50),
            
            navigationController!.toolbar.heightAnchor.constraint(equalToConstant: 100),
            
            watchButton.topAnchor.constraint(equalTo: navigationController!.toolbar.topAnchor, constant: 5),
            watchButton.centerXAnchor.constraint(equalTo: navigationController!.toolbar.centerXAnchor),
            
            watchButton.widthAnchor.constraint(equalToConstant: 180),
            watchButton.heightAnchor.constraint(equalToConstant: 55),
            
        ])
    }
}

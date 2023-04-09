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
    let storyLine = StoryLineView()
    private var movies: [Movie] = [Movie]()
    
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
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView:UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Movie Detail"

        setupViews()
        setConstraints()
        setupNavBar()
    addStarsToStartView()
    }
    
    
    func addStarsToStartView() {
        let numberOfStars = 5
        for star in 1...numberOfStars {
            let starImage:UIImageView = {
                let imageView = UIImageView()
                imageView.image = UIImage(systemName: "star.fill")
                imageView.tintColor = .yellow
                return imageView
            }()
            stackView.addArrangedSubview(starImage)
        }
    }
    
    private func setupNavBar() {
        
        navigationItem.leftBarButtonItem =  UIBarButtonItem(image: UIImage(systemName: "arrow.left.circle.fill"), style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .done, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .gray
    }
    
    private func setupViews() {
        view.addSubview(posterImage)
        view.addSubview(posterTitle)
        view.addSubviews(additionalInfo)
        view.addSubviews(stackView)
        view.addSubview(storyLine)
    }
    
    func configure(with model: DetailMovieViewModel) {
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.posterURL)") else { return }
        posterImage.kf.setImage(with: url)
        posterTitle.text = model.titleName
        additionalInfo.dataReleaseLabel.text = model.releaseDate
        storyLine.storyLineTextView.text = model.overview
        additionalInfo.runTimeLabel.text = "\(model.runtime)"
    }
}

extension DetailVC {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            posterImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            posterImage.widthAnchor.constraint(equalToConstant: 200),
            posterImage.heightAnchor.constraint(equalToConstant: 300),
            
            posterTitle.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 10),
            posterTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
            additionalInfo.topAnchor.constraint(equalTo: posterTitle.bottomAnchor, constant: 20),
            additionalInfo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            additionalInfo.widthAnchor.constraint(equalToConstant: 350),
            additionalInfo.heightAnchor.constraint(equalToConstant: 30),
        
            stackView.topAnchor.constraint(equalTo: additionalInfo.bottomAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.widthAnchor.constraint(equalToConstant: 100),
            stackView.heightAnchor.constraint(equalToConstant: 16),
       
            storyLine.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            storyLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            storyLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            storyLine.heightAnchor.constraint(equalToConstant: 170),
        
        ])
        
    }
}

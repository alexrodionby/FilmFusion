//
//  DetailViewController.swift
//  FilmFusion
//
//  Created by Sergey Azimov on 04.04.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    let detailSubview = DetailSubview()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleMovie: UILabel = {
        let label = UILabel()
        label.text = "Title Movie"
        label.backgroundColor = .green
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
//    private let dataReleaseImage = UIImageView(systemName: "calendar")
//    private let dataReleaseLabel = UILabel(text: "12.12.12")
//
//    private let runTimeImage = UIImageView(systemName: "clock.fill")
//    private let runTimeLable = UILabel(text: "148 Minutes")
//
//    private let genreImage = UIImageView(systemName: "film")
//    private let genreLabel = UILabel(text: "Action")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        settingNavBar()
    
        setupViews()
        setConstraints()
       
    }
    
    private func settingNavBar() {
        navigationItem.title = "Movie Detail"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward.circle"), style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "suit.heart"), style: .done, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .gray
    }
    
    private func setupViews() {
        view.addSubview(posterImageView)
        view.addSubview(titleMovie)
        view.addSubview(detailSubview)
    }
    
}


extension DetailViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            posterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
            posterImageView.widthAnchor.constraint(equalToConstant: 220),
            posterImageView.heightAnchor.constraint(equalToConstant: 300),
        
            titleMovie.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 20),
            titleMovie.centerXAnchor.constraint(equalTo: view.centerXAnchor),
       
            titleMovie.widthAnchor.constraint(equalToConstant: 200),
            titleMovie.heightAnchor.constraint(equalToConstant: 20),
        
            detailSubview.topAnchor.constraint(equalTo: titleMovie.bottomAnchor, constant: 15),
            detailSubview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            detailSubview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            detailSubview.heightAnchor.constraint(equalToConstant: 30)
        
        ])
    }
    
}

//
//  DetailVC.swift
//  FilmFusion
//
//  Created by Sergey Azimov on 05.04.2023.
//

import UIKit
import SnapKit

class DetailVC: UIViewController {
    
    private let posterImage: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = .green
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let posterTitle: UILabel = {
        let label = UILabel()
        label.text = "Movie name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.addSubview(posterImage)
        view.addSubview(posterTitle)
        
    }
    
    
}

extension DetailVC {
    
    private func setConstraints() {
        
        
    }
    
}

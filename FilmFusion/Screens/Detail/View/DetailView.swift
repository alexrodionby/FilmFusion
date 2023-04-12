//
//  DetailView.swift
//  FilmFusion
//
//  Created by Sergey Azimov on 05.04.2023.
//

import UIKit

class DetailView: UIView {
    
    let dataReleaseImage = UIImageView(name: "calendar")
    let dataReleaseLabel = UILabel(text: "12.12.12")
    
    let runTimeImage = UIImageView(name: "clock")
    let runTimeLabel = UILabel(text: "000 Minutes")
    
    let genreImage = UIImageView(name: "film")
    let genreLable = UILabel(text: "Action")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setup Views
    private func setupViews() {
        addSubview(dataReleaseImage)
        addSubview(dataReleaseLabel)
        
        addSubview(runTimeImage)
        addSubview(runTimeLabel)
        
        addSubview(genreImage)
        addSubview(genreLable)
    }
    
}

//MARK: - setConstraints
extension DetailView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            dataReleaseImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dataReleaseImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            dataReleaseImage.widthAnchor.constraint(equalToConstant: 15),
            dataReleaseImage.heightAnchor.constraint(equalToConstant: 15),
        
            dataReleaseLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            dataReleaseLabel.leadingAnchor.constraint(equalTo: dataReleaseImage.trailingAnchor, constant: 5),
            
            runTimeImage.leadingAnchor.constraint(equalTo: dataReleaseLabel.trailingAnchor, constant: 25),
            runTimeImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            runTimeImage.widthAnchor.constraint(equalToConstant: 15),
            runTimeImage.heightAnchor.constraint(equalToConstant: 15),
            
            runTimeLabel.leadingAnchor.constraint(equalTo: runTimeImage.trailingAnchor, constant: 5),
            runTimeLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            genreImage.leadingAnchor.constraint(equalTo: runTimeLabel.trailingAnchor, constant: 25),
            genreImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            genreImage.widthAnchor.constraint(equalToConstant: 15),
            genreImage.heightAnchor.constraint(equalToConstant: 15),
            
            genreLable.leadingAnchor.constraint(equalTo: genreImage.trailingAnchor, constant: 5),
            genreLable.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

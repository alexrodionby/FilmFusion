//
//  DetailSubview.swift
//  FilmFusion
//
//  Created by Sergey Azimov on 04.04.2023.
//

import Foundation
import UIKit
class DetailSubview: UIView {
    
    
    private let dataReleaseImage = UIImageView(systemName: "calendar")
    private let dataReleaseLabel = UILabel(text: "12.12.12")
    
    private let runTimeImage = UIImageView(systemName: "clock.fill")
    private let runTimeLable = UILabel(text: "148 Minutes")
    
    private let genreImage = UIImageView(systemName: "film")
    private let genreLabel = UILabel(text: "Action")
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
        setConstraints()
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
private func setupViews() {
addSubview(dataReleaseImage)
 addSubview(dataReleaseLabel)
    addSubview(runTimeImage)
    addSubview(runTimeLable)
    addSubview(genreImage)
    addSubview(genreLabel)
    }
}
extension DetailSubview {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
        
            dataReleaseImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            dataReleaseImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            
          dataReleaseLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            dataReleaseLabel.leadingAnchor.constraint(equalTo: dataReleaseImage.trailingAnchor, constant: 5),
        
            runTimeImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            runTimeImage.leadingAnchor.constraint(equalTo: dataReleaseLabel.trailingAnchor, constant: 25),
            
            runTimeLable.centerYAnchor.constraint(equalTo: centerYAnchor),
            runTimeLable.leadingAnchor.constraint(equalTo: runTimeImage.trailingAnchor, constant: 5),
        
            genreImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            genreImage.leadingAnchor.constraint(equalTo: runTimeLable.trailingAnchor, constant: 25),
            
            genreLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            genreLabel.leadingAnchor.constraint(equalTo: genreImage.trailingAnchor, constant: 5),
        ])
    }
    
}

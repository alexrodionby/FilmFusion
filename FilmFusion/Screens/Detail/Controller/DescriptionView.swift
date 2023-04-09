//
//  StoryLineView.swift
//  FilmFusion
//
//  Created by Sergey Azimov on 05.04.2023.
//

import UIKit

class DescriptionView: UIView {
    
    let descriptionText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book "
    
    private let storyLineTitle: UILabel = {
        let label = UILabel()
        label.text = "Story Line"
        label.font = UIFont.PlusJakartaSansBold16()
        label.textColor = UIColor(named: "customLabelName")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let storyLineTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.isSelectable = false
        textView.isScrollEnabled = false
        textView.textContainer.heightTracksTextView = true
        textView.isEditable = false
        textView.font = UIFont.PlusJakartaSansMedium14()
        textView.textColor = UIColor(named: "customMiniLabel")
        textView.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen bookLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book "
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
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
        addSubview(storyLineTitle)
        addSubview(storyLineTextView)
    }
}
//MARK: - setConstraints
extension DescriptionView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            storyLineTitle.topAnchor.constraint(equalTo: topAnchor),
            storyLineTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            storyLineTitle.heightAnchor.constraint(equalToConstant: 30),
            storyLineTitle.widthAnchor.constraint(equalToConstant: 80),
            
            storyLineTextView.topAnchor.constraint(equalTo: storyLineTitle.bottomAnchor, constant: 10),
            storyLineTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            storyLineTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            storyLineTextView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
    }
    
}

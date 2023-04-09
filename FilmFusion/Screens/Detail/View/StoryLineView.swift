//
//  StoryLineView.swift
//  FilmFusion
//
//  Created by Sergey Azimov on 05.04.2023.
//

import UIKit

class StoryLineView: UIView {
    
    private let storyLineTitle: UILabel = {
        let label = UILabel()
        label.text = "Story Line"
        label.translatesAutoresizingMaskIntoConstraints = false
    return label
    }()
    
    let storyLineTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.isSelectable = false
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book "
        textView.font = UIFont(name: "Avenir-Roman", size: 14)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupViews()
        setConstraints()
        backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(storyLineTitle)
        addSubview(storyLineTextView)
    }
    
    
    
}

extension StoryLineView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
        
            storyLineTitle.topAnchor.constraint(equalTo: topAnchor),
            storyLineTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            storyLineTitle.heightAnchor.constraint(equalToConstant: 30),
            storyLineTitle.widthAnchor.constraint(equalToConstant: 80),
            
            storyLineTextView.topAnchor.constraint(equalTo: storyLineTitle.bottomAnchor, constant: 16),
            storyLineTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            storyLineTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            storyLineTextView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
        
    }
    
}

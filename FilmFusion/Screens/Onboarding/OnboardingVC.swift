//
//  OnboardingVC.swift
//  FilmFusion
//
//  Created by Eldar Garbuzov on 12.04.23.
//

import UIKit
import CHIPageControl

final class OBScreen: UIViewController {
    
    fileprivate var index = 0
    fileprivate var progressIndex = 0
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        let profile = UIImage(named: "OBGirl1")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = profile
        
        return imageView
    }()
    
    private let descriptionTextView: UITextView = {
        
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Text1", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 24)])
        
        attributedText.append(NSAttributedString(string: "\n\nAre you ready for loads and loads for fun? \nDon't wait any longer! \nWe hope to see you in our event today.", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor(named: "AdditionalTextColor") as Any]))
        
        textView.attributedText = attributedText
        
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textColor = UIColor(named: "LabelTextColor")
        textView.backgroundColor = UIColor(named: "ViewColorSet")
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .mainPurple
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let pageControl: CHIPageControlAleppo = {
        let pageControl = CHIPageControlAleppo(frame: CGRect(x: 0, y:0, width: 100, height: 20))
        pageControl.numberOfPages = 3
        pageControl.radius = 5
        pageControl.currentPageTintColor = .mainPurple
        pageControl.padding = 10
        pageControl.tintColors = [UIColor.lightGray, UIColor.lightGray, UIColor.lightGray]
        pageControl.set(progress: 0, animated: true)
        pageControl.enableTouchEvents = true
        pageControl.backgroundColor = UIColor(named: "ViewColorSet")
        return pageControl
    }()
    
    private let whiteRound: UIView = {
        let round = UIView(frame: CGRect(x: 74, y: 263, width: 8, height: 8))
        round.layer.cornerRadius = round.frame.width / 2
        round.clipsToBounds = true
        round.backgroundColor = .white
        return round
    }()
    private let whiteRound1: UIView = {
        let round = UIView(frame: CGRect(x: 128, y: 69, width: 12, height: 12))
        round.layer.cornerRadius = round.frame.width / 2
        round.clipsToBounds = true
        round.backgroundColor = .white
        return round
    }()
    private let whiteRound2: UIView = {
        let round = UIView(frame: CGRect(x: 333, y: 290, width: 12, height: 12))
        round.layer.cornerRadius = round.frame.width / 2
        round.clipsToBounds = true
        round.backgroundColor = .white
        return round
    }()
    private let whiteRound3: UIView = {
        let round = UIView(frame: CGRect(x: 292, y: 196, width: 19, height: 19))
        round.layer.cornerRadius = round.frame.width / 2
        round.clipsToBounds = true
        round.backgroundColor = .white
        return round
    }()
    private let roundWithImg: UIView = {
        let round = UIView(frame: CGRect(x: 24, y: 147, width: 44, height: 44))
        round.layer.cornerRadius = round.frame.width / 2
        round.clipsToBounds = true
        round.backgroundColor = UIColor(red: 254/255, green: 254/255, blue: 254/255, alpha: 0.4)
        return round
    }()
    private let roundWithImg1: UIView = {
        let round = UIView(frame: CGRect(x: 299, y: 87, width: 34, height: 34))
        round.layer.cornerRadius = round.frame.width / 2
        round.clipsToBounds = true
        round.backgroundColor = UIColor(red: 254/255, green: 254/255, blue: 254/255, alpha: 0.4)
        return round
    }()
    private let ingForRound: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 25, y: 149, width: 42, height: 42))
        imageView.image = UIImage(named: "bx-play-circle")
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.transform = imageView.transform.rotated(by: .pi / 1.5)
        imageView.clipsToBounds = true
        return imageView
    }()
    private let ingForRound1: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 307, y: 95, width: 18, height: 18))
        imageView.image = UIImage(named: "bx-movie-play")
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(profileImageView)
        view.addSubview(descriptionTextView)
        setupBottomControls()
        view.addSubview(nextButton)
        setupLayout()
        view.addSubview(whiteRound)
        view.addSubview(whiteRound1)
        view.addSubview(whiteRound2)
        view.addSubview(whiteRound3)
        view.addSubview(roundWithImg)
        view.addSubview(roundWithImg1)
        view.addSubview(ingForRound)
        view.addSubview(ingForRound1)
        view.backgroundColor = .mainPurple
    }
    
    private func textForTextView() {
        
        if index == 0 {
            let at = NSMutableAttributedString(string: "Text2", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 24)])
            at.append(NSAttributedString(string: "\n\nDon't wait any longer! \nAre you ready for loads and loads for fun? \nWe hope to see you in our event today.", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor(named: "AdditionalTextColor") as Any]))
            self.descriptionTextView.attributedText = at
            self.descriptionTextView.textAlignment = .center
            self.descriptionTextView.textColor = UIColor(named: "LabelTextColor")
            self.profileImageView.image = UIImage(named: "OBGirl2")
            
            index += 1
            print("INDEX \(index)")
        } else {
            let at2 = NSMutableAttributedString(string: "Text3", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 24)])
            at2.append(NSAttributedString(string: "\n\nAre you ready for loads and loads for fun? \nWe hope to see you in our event today. \nDon't wait any longer!", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor(named: "AdditionalTextColor") as Any]))
            self.descriptionTextView.attributedText = at2
            self.descriptionTextView.textAlignment = .center
            self.descriptionTextView.textColor = UIColor(named: "LabelTextColor")
            self.profileImageView.image = UIImage(named: "OBGirl3")
        }
    }
    
    @objc func nextButtonTapped() {
        
        progressIndex += 1
        pageControl.set(progress: progressIndex, animated: true)
        
        UIView.animate(withDuration: 1.2) {
            self.profileImageView.alpha = 0
            
        }
        UIView.animate(withDuration: 1.2) {
            self.profileImageView.alpha = 1
            self.textForTextView()
        }
    }
    
    fileprivate func setupBottomControls(){
        
        let yellowView = UIView()
        yellowView.backgroundColor = .yellow
        
        let greenView = UIView()
        greenView.backgroundColor = .green
        
        let blueView = UIView()
        blueView.backgroundColor = .blue
        let bottomControlsStackView = UIStackView(arrangedSubviews: [pageControl, descriptionTextView])
        
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillProportionally
        bottomControlsStackView.axis = .vertical
        bottomControlsStackView.layer.cornerRadius = 30
        bottomControlsStackView.clipsToBounds = true
        bottomControlsStackView.backgroundColor = #colorLiteral(red: 0.09019607843, green: 0.09019607843, blue: 0.1450980392, alpha: 1)
        
        view.addSubview(bottomControlsStackView)
        
        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            bottomControlsStackView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 15),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 325)
        ])
    }
    
    private func setupLayout(){
        let topImageContainerView = UIView()
        view.addSubview(topImageContainerView)
        
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        topImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topImageContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        topImageContainerView.addSubview(profileImageView)
        
        pageControl.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        profileImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        
        descriptionTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        descriptionTextView.topAnchor.constraint(equalTo: pageControl.bottomAnchor).isActive = true
        
        
        nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90).isActive = true
        nextButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
}


//
//  LaunchAnimationVC.swift
//  FilmFusion
//
//  Created by Eldar Garbuzov on 12.04.23.
//

import UIKit
import Foundation

final class LaunchAnimationVC: UIViewController {
    
    private let centerRoundView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 152, y: 289, width: 0, height: 0))
        imageView.backgroundColor = .white
        imageView.alpha = 0.4
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let imageForRound: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 165, y: 304, width: 60, height: 60))
        imageView.image = UIImage(named: "bxs-movie-play")
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.clipsToBounds = true
        imageView.alpha = 0
        return imageView
    }()
    
    private let textLable: UILabel = {
        let label = UILabel(frame: CGRect(x: 113, y: 407, width: 165, height: 24))
        label.text = "FilmFusion"
        label.font = .boldSystemFont(ofSize: 32)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let spinnerView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 161, y: 701, width: 70, height: 70))
        imageView.image = UIImage(named: "Loading")
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "LSColorSet")
       
        view.addSubview(centerRoundView)
        view.addSubview(imageForRound)
        view.addSubview(textLable)
        view.addSubview(spinnerView)
        playlogoAnimation()
    }
    
   private func playlogoAnimation() {
        UIView.animate(withDuration: 0.4) {
            self.centerRoundView.frame = CGRect(x: 152, y: 289, width: 88, height: 88)
            self.centerRoundView.layer.cornerRadius = self.centerRoundView.frame.width / 2
            self.centerRoundView.clipsToBounds = true
        }
        UIView.animate(withDuration: 1) {
            self.imageForRound.alpha = 1
        }
        UIView.animate(withDuration: 4) {
            for _ in 1...10 {
                self.spinnerView.rotate(angle: 15)
            }
        }
        let timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(delayedAction), userInfo: nil, repeats: false)
    }
    @objc func delayedAction() {
        let vc = AuthVC()
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
}



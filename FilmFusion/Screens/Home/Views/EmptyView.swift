//
//  emptyView.swift
//  AFMovie
//
//  Created by Alex F on 6.04.23.
//

import UIKit
class EmptyView: UIView {
    
    var imageView = UIImageView()
    var titleLabel = UILabel()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .yellow
      

    }

}

//
//  FilterView.swift
//  FilmFusion
//
//  Created by Лерочка on 06.04.2023.
//


import UIKit

final class FilterView: UIView {
    var categories = ["all", "side dish", "dessert", "appetizer", "salad", "bread", "breakfast", "soup", "beverage", "sauce", "marinade", "fingerfood", "snack", "drink"]
    var isSelected = true
    var lastIndexActive:IndexPath = [1 ,0]
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "Categories"
        label.textColor = UIColor(named: "customLabelName")
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    lazy var filterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "Star Rating"
        label.textColor = UIColor(named: "customLabelName")
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
        lazy var categoryCollectionView: UICollectionView = {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .horizontal
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.backgroundColor = UIColor(named: "customBackground")
            return collectionView
        }()
    
    lazy var ratingCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor(named: "customBackground")
        return collectionView
    }()
 
    lazy var closeFilterButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "Clear"), for: .normal)
        button.addTarget(self, action: #selector(closeFilterButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var applyFiltersButton: UIButton = {
        let button = UIButton()
//        button.titleLabel?.text = "Apply Filters"
        button.titleLabel?.textColor = .white
//        button.backgroundColor = UIColor(named: "customTabBarIconSelectedTint")
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.layer.masksToBounds = true
//        button.setBackgroundImage(UIImage(named: "Filter"), for: .normal)
        button.addTarget(self, action: #selector(applyFiltersButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var resetFiltersButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "Reset Filters"
        button.titleLabel?.textColor = .red//UIColor(named: "customTabBarIconSelectedTint")
//        button.setBackgroundImage(UIImage(named: "Filter"), for: .normal)
        button.addTarget(self, action: #selector(resetFiltersButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func closeFilterButtonPressed() {
        print("close")
    }
    @objc func applyFiltersButtonPressed() {
        print("apply")
        
    }
    
    @objc func resetFiltersButtonPressed() {
        print("resent")
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        categoryCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        ratingCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        addSubviews(categoryCollectionView, ratingCollectionView, closeFilterButton, applyFiltersButton,filterLabel,categoryLabel,resetFiltersButton)

        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            closeFilterButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            closeFilterButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
//            closeFilterButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            filterLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            filterLabel.leadingAnchor.constraint(equalTo: closeFilterButton.trailingAnchor, constant: 10),
            
            resetFiltersButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            resetFiltersButton.leadingAnchor.constraint(equalTo: filterLabel.trailingAnchor, constant: 100),
            resetFiltersButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),

//            categoryCollectionView.topAnchor.constraint(equalTo: searchView.bottomAnchor),
//            categoryCollectionView.centerYAnchor.constraint(equalTo: topAnchor, constant: 100),
//            categoryCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -10),
//            categoryCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
         
            
        ])
    }
}

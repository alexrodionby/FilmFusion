//
//  SearchView.swift
//  FilmFusion
//
//  Created by Лерочка on 04.04.2023.
//

import UIKit

final class SearchView: UIView {
    var categories = ["all", "side dish", "dessert", "appetizer", "salad", "bread", "breakfast", "soup", "beverage", "sauce", "marinade", "fingerfood", "snack", "drink"]
    var isSelected = true
    var lastIndexActive:IndexPath = [1 ,0]
    lazy var searchView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        view.layer.borderColor = UIColor(named: "customTabBarIconSelectedTint")?.cgColor
        view.layer.borderWidth = 1
        view.heightAnchor.constraint(equalToConstant: 52).isActive = true
        view.widthAnchor.constraint(equalToConstant: 327).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Search"
        textField.backgroundColor = .clear
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 24).isActive = true
        textField.setIcon(UIImage(named: "Search")!)
        return textField
    }()
    
        lazy var searchTableView: UITableView = {
            let tableView = UITableView()
//            tableView.rowHeight = 180
//            tableView.layer.cornerRadius = 10
            tableView.translatesAutoresizingMaskIntoConstraints = false
            return tableView
        }()
    
        lazy var categoryCollectionView: UICollectionView = {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .horizontal
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.backgroundColor = .white
            return collectionView
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
                searchTableView.register(FilmTableViewCell.self, forCellReuseIdentifier: FilmTableViewCell.identifier)
        categoryCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        //        tableView.register(CustomHeader.self, forHeaderFooterViewReuseIdentifier: "sectionHeader")
        //        addSubviews(searchBar, tableView)
        searchView.addSubview(searchTextField)
        addSubviews(searchView, searchTextField,categoryCollectionView,searchTableView)

        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            searchView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            searchView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -24),
            
            searchTextField.topAnchor.constraint(equalTo: topAnchor,constant: 25),
            searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -35),
            
            categoryCollectionView.topAnchor.constraint(equalTo: searchView.bottomAnchor),
            categoryCollectionView.centerYAnchor.constraint(equalTo: topAnchor, constant: 100),
            categoryCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -10),
            categoryCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            

            searchTableView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor),
            searchTableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -27),
            searchTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            searchTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
                
            
        ])
    }
}

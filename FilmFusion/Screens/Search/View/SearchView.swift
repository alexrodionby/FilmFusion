//
//  SearchView.swift
//  FilmFusion
//
//  Created by Лерочка on 04.04.2023.
//

import UIKit

//@available(iOS 15.0, *)
final class SearchView: UIView {
    var categories = ["all", "side dish", "dessert", "appetizer", "salad", "bread", "breakfast", "soup", "beverage", "sauce", "marinade", "fingerfood", "snack", "drink"]
    var isSelected = true
    var lastIndexActive:IndexPath = [1 ,0]
    lazy var searchView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "customBackground")
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
        textField.backgroundColor = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 24).isActive = true
        textField.setIcon(UIImage(named: "Search")!)
        return textField
    }()
    
        lazy var searchTableView: UITableView = {
            let tableView = UITableView()
//            tableView.rowHeight = 180
//            tableView.layer.cornerRadius = 10
            tableView.separatorStyle = .none
            tableView.translatesAutoresizingMaskIntoConstraints = false
            return tableView
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
    
    lazy var seporatorImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "Vector"))
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        return image
    }()
 
    lazy var clearSearchButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "Clear"), for: .normal)
        button.addTarget(self, action: #selector(clearButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var filterSearchButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "Filter"), for: .normal)
//        button.addTarget(self, action: #selector(filterButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func clearButtonPressed() {
        searchTextField.text = ""
        print("clear")
    }
//    @available(iOS 15.0, *)
//    @objc func filterButtonPressed() {
//        print("filter")
//        let viewControllerToPresent = FilterVC()
//          if let sheet = viewControllerToPresent.sheetPresentationController {
//              sheet.detents = [.medium(), .large()]
//              sheet.largestUndimmedDetentIdentifier = .medium
//              sheet.prefersScrollingExpandsWhenScrolledToEdge = false
//              sheet.prefersEdgeAttachedInCompactHeight = true
//              sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
//          }
////          present(viewControllerToPresent, animated: true, completion: nil)
//      }
        
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
                searchTableView.register(FilmTableViewCell.self, forCellReuseIdentifier: FilmTableViewCell.identifier)
        categoryCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        //        tableView.register(CustomHeader.self, forHeaderFooterViewReuseIdentifier: "sectionHeader")
        //        addSubviews(searchBar, tableView)
        searchView.addSubviews(searchTextField,clearSearchButton,filterSearchButton,seporatorImage)
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
            
            searchTextField.topAnchor.constraint(equalTo: searchView.topAnchor,constant: 15),
            searchTextField.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: 10),
            searchTextField.trailingAnchor.constraint(equalTo:searchView.trailingAnchor,constant: -60),
            
            clearSearchButton.topAnchor.constraint(equalTo: searchView.topAnchor,constant: 21),
            clearSearchButton.leadingAnchor.constraint(equalTo: searchTextField.trailingAnchor, constant: 5),
//            clearSearchButton.bottomAnchor.constraint(equalTo: searchView.bottomAnchor,constant: -20),
            
            seporatorImage.topAnchor.constraint(equalTo: searchView.topAnchor,constant: 17),
            seporatorImage.leadingAnchor.constraint(equalTo: clearSearchButton.trailingAnchor, constant: 7),
            
            filterSearchButton.topAnchor.constraint(equalTo: searchView.topAnchor,constant: 20),
            filterSearchButton.leadingAnchor.constraint(equalTo: seporatorImage.trailingAnchor, constant: 7),
            
            categoryCollectionView.topAnchor.constraint(equalTo: searchView.bottomAnchor),
            categoryCollectionView.centerYAnchor.constraint(equalTo: topAnchor, constant: 100),
            categoryCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -10),
            categoryCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            

            searchTableView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor),
            searchTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            searchTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchTableView.trailingAnchor.constraint(equalTo: trailingAnchor)
                
            
        ])
    }
}

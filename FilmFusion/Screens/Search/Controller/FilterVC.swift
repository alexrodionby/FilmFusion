//
//  FilterVC.swift
//  FilmFusion
//
//  Created by Лерочка on 06.04.2023.
//

import UIKit

class FilterVC: UIViewController {

    private let filterView = FilterView()
//    var selectedCategory = "all"
    override func viewDidLoad() {
        super.viewDidLoad()
//        searchView.categoryCollectionView.dataSource = self
//        searchView.categoryCollectionView.delegate = self
//        searchView.searchTableView.dataSource = self
//        searchView.searchTableView.delegate = self
        setupView()
//        fetchDiscoverMovies()
//        title = "Search"
        view.backgroundColor = UIColor(named: "customBackground")

    }
    
    private func setupView() {
        view.addSubview(filterView)
        NSLayoutConstraint.activate([
            filterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filterView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            filterView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            filterView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

}

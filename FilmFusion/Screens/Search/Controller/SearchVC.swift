//
//  SearchVC.swift
//  FilmFusion
//
//  Created by Alexandr Rodionov on 3.04.23.
//

import UIKit

class SearchVC: UIViewController {
    
    private let searchView = SearchView()
    var selectedCategory = "all"
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.categoryCollectionView.dataSource = self
        searchView.categoryCollectionView.delegate = self
        searchView.searchTableView.dataSource = self
        searchView.searchTableView.delegate = self
        setupView()
        title = "Search"
        view.backgroundColor = .white
    }
    
    
    private func setupView() {
        view.addSubview(searchView)
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupUICell(cell: UICollectionViewCell, backColor: UIColor, borderColor: UIColor) {
        cell.backgroundColor = backColor
        cell.layer.masksToBounds = false
        cell.layer.cornerRadius = 15
        cell.layer.borderColor = borderColor.cgColor
        cell.layer.borderWidth = 1
    }
    
}


extension SearchVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        searchView.isSelected = false
        if searchView.lastIndexActive != indexPath {
            
            let cell = collectionView.cellForItem(at: indexPath) as! CategoryCell
            setupUICell(cell: cell, backColor: UIColor(named: "customTabBarIconSelectedTint")!, borderColor: .clear)
//            let label = cell.viewWithTag(100) as? UILabel
//                    label?.textColor = UIColor.white
            cell.categoryLabel.textColor = .white
            selectedCategory = searchView.categories[indexPath.row]
            
            if let cell1 = collectionView.cellForItem(at: searchView.lastIndexActive) as? CategoryCell {
                setupUICell(cell: cell1, backColor: .white, borderColor: UIColor(named: "customCategoryBoard")!)
                cell1.categoryLabel.textColor = UIColor(named: "customCategoryTextUnselected")!
            }
            searchView.lastIndexActive = indexPath
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if searchView.isSelected && indexPath == [0,0]{
            setupUICell(cell: cell, backColor: UIColor(named: "customTabBarIconSelectedTint")!, borderColor: .clear)
//            cell.categoryLabel.textColor = .white
            searchView.isSelected = false
            searchView.lastIndexActive = [0,0]
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchView.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
        setupUICell(cell: cell, backColor: .white, borderColor: UIColor(named: "customCategoryBoard")!)
        if searchView.isSelected == false {
            cell.categoryLabel.textColor = UIColor(named: "customCategoryTextUnselected")!
        }
      
        let category = "\(searchView.categories[indexPath.row])  "
        cell.configure(with: category)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = searchView.categories[indexPath.row]
        let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize: 14.0)]).width + 40.0
        return CGSize(width: cellWidth, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20) //отступы от секции
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilmTableViewCell.identifier, for: indexPath) as! FilmTableViewCell
        //        cell.configure(recipe)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("SELECTED!!!!!!!")
    }
}


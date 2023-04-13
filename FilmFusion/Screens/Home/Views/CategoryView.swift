//
//  CategoriesView.swift
//  AFMovie
//
//  Created by Alex F on 6.04.23.
//

import UIKit

class CategoryView: UIView, UICollectionViewDelegate {
 
    let categories: [Category] = [
        Category(title: "All"), Category(title: "Actdededeion"), Category(title: "Adventure"), Category(title: "Mystery"), Category(title: "Fantasy"), Category(title: "Uhti"), Category(title: "Actdededev ion3"),
    ]
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let layout = UICollectionViewFlowLayout()
    
    enum CatSection: CaseIterable {
        case main
    }
    var dataSource: UICollectionViewDiffableDataSource<CatSection, Category>?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Category"
        return label
    }()
    
    let boxOfficeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Box office"
        return label
    }()
    
    let dragBar: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray.withAlphaComponent(0.2) // СИСТЕМНЫЙ  синий!!!!
        view.layer.cornerRadius = 3
        view.clipsToBounds = true
        return view
        
        
    }()
    
//    let seeAllButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("See All", for: .normal)
//        if #available(iOS 15.0, *) {
//            button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
//        } else {
//            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        }
//
//        return button
//    }()
    
    let seeAllLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "See All"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(titleLabel)
        self.addSubview(collectionView)
        self.addSubview(boxOfficeLabel)
        self.addSubview(seeAllLabel)
        self.addSubview(dragBar)
        
        setupCollectionView()
        setupConstraints()

        createDataSource()
        reloadData()

    }
    
    func setupCollectionView() {
        collectionView.register(CategoriesCell.self, forCellWithReuseIdentifier: CategoriesCell.reuseId)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 25, bottom: 12, right: 0)
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
                
        
        collectionView.collectionViewLayout = layout
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        layout.minimumInteritemSpacing = 10.0
//        collectionView.backgroundColor = .red

    }
    
// MARK: - Setup Constraints
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(25)
        }
        collectionView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.leading.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.bottom.equalTo(boxOfficeLabel.snp.top).offset(-6)
        }
        
        boxOfficeLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        seeAllLabel.snp.makeConstraints { make in
            make.bottom.equalTo(boxOfficeLabel)
            make.trailing.equalToSuperview().offset(-25)
        }
        dragBar.snp.makeConstraints { make in
            make.width.equalTo(86)
            make.height.equalTo(4)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-8)
        }
    }
}

// MARK: - Datasource + update
extension CategoryView {
        func createDataSource() {
            dataSource = UICollectionViewDiffableDataSource<CatSection, Category>(collectionView: collectionView, cellProvider: { collectionView, indexPath, category -> UICollectionViewCell? in
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.reuseId, for: indexPath) as? CategoriesCell
                    cell?.configure(with: category)
                    return cell
            })
        }

        func reloadData() {
            var snapshot = NSDiffableDataSourceSnapshot<CatSection, Category>()
            snapshot.appendSections([.main])
            snapshot.appendItems(categories)
            dataSource?.apply(snapshot)
        }
    
}
extension CategoryView {
    
}

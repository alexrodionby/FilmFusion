//
//  SearchVC.swift
//  FilmFusion
//
//  Created by Alexandr Rodionov on 3.04.23.
//

import UIKit

class SearchVC: UIViewController {
    
    var movies: [Movie] = [Movie]()
    
    let searchView = SearchView()
    var selectedCategory = "Random"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.categoryCollectionView.dataSource = self
        searchView.categoryCollectionView.delegate = self
        searchView.searchTableView.dataSource = self
        searchView.searchTableView.delegate = self
        
        setupView()
        fetchDiscoverMovies()
        searchView.searchTextField.delegate = self
        
        title = "Search"
        view.backgroundColor = UIColor(named: "customBackground")
    }
    
    private func fetchDiscoverMovies() {
        APICaller.shared.getDiscoverMovies() { [weak self] results in
            switch results {
            case.success(let movies):
                print("1st request")
                self?.movies = movies
                DispatchQueue.main.async {
                    self?.searchView.searchTableView.reloadData()
                }
            case.failure(let error):
                print(error)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        searchView.searchTableView.reloadData()
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
            cell.categoryLabel.textColor = .white
            selectedCategory = searchView.categories[indexPath.row]
            
           
            APICaller.shared.searchByGenre(with: selectedCategory) { [weak self] results in
                switch results {
                case.success(let movies):
                    print("1st request")
                    self?.movies = movies
                    print("ФИЛЬМЫ", self?.movies as Any)
                    DispatchQueue.main.async {
                        self?.searchView.searchTableView.reloadData()
                    }
                case.failure(let error):
                    print(error)
                }
            }
            
            
            if let cell1 = collectionView.cellForItem(at: searchView.lastIndexActive) as? CategoryCell {
                setupUICell(cell: cell1, backColor: UIColor(named: "customBackground")!, borderColor: UIColor(named: "customCategoryBoard")!)
                cell1.categoryLabel.textColor = UIColor(named: "customCategoryTextUnselected")!
            }
            searchView.lastIndexActive = indexPath
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if searchView.isSelected && indexPath == [0,0]{
            setupUICell(cell: cell, backColor: UIColor(named: "customTabBarIconSelectedTint")!, borderColor: .clear)
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
        cell.backgroundColor = .red
        setupUICell(cell: cell, backColor: UIColor(named: "customBackground")!, borderColor: UIColor(named: "customCategoryBoard")!)
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
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilmTableViewCell.identifier, for: indexPath) as! FilmTableViewCell
        
        let id = movies[indexPath.row].id
        let movies = movies[indexPath.row]
        print("Одно кино", movies)
        APICaller.shared.getDetailsMovies(id: id) { [weak self] results in
            switch results {
            case.success(let movies):
                print("Работает")
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.searchView.searchTableView.reloadData()
                }
            case.failure(let error):
                print("Запрос не работает\(error)")
            }
        }
        
        let model = MovieViewModel(id: id, titleName: movies.original_title ?? movies.original_name ?? "", posterURL: movies.poster_path ?? "", releaseDate: movies.release_date ?? "", voteAverage: movies.vote_average, voteCount: movies.vote_count, runtime: movies.runtime ?? movies.id)
        print("Жанры этого кино ", movies.genres?.first?.name)
        cell.configure(with: model)
        print(model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movies = movies[indexPath.row]
        DispatchQueue.main.async {
            let vc = DetailVC()
            let model = DetailMovieViewModel(id: movies.id, titleName: movies.title , posterURL: movies.poster_path ?? "", releaseDate: movies.release_date ?? "", voteAverage: movies.vote_average, overview: movies.overview ?? "" , runtime: movies.runtime ?? 0)
            vc.configure(with: model)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let searchText = textField.text else {
            return false
        }
        
        searchWithText(searchText)
        print("Ищем по сллову")
        textField.resignFirstResponder()
        return true
    }
    
    func searchWithText(_ text: String) {
        print("Запрос со словом", text)
        
        APICaller.shared.search(with: text) { [weak self] results in
            switch results {
            case.success(let movies):
                print("Получили ответ по серчу")
                self?.movies = movies
                DispatchQueue.main.async {
                    self?.searchView.searchTableView.reloadData()
                }
            case.failure(let error):
                print(error)
            }
        }
    }
}

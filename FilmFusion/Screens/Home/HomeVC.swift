//
//  ViewController.swift
//  AFMovie
//
//  Created by Alex Fount on 5.04.23.
//
protocol implementHomeVC {
    func pushDetailVC(from indexPath: IndexPath)
    func reloadDataRand()
}

import UIKit
import SnapKit

class HomeVC: UIViewController, UIScrollViewDelegate, UITableViewDelegate, implementHomeVC {
 
    enum Section: CaseIterable {
        case mainFilms
    }
    private let avatarView = AvatarView()
    
    var movies: [Movie] = [Movie]()
    
    var dataSource: UITableViewDiffableDataSource<Section, Movie>?

    private let scrollView = UIScrollView()
    private let cardsView = CardsView()
    private let categoryView = CategoryView()
    private let tableView = UITableView()

    var viewInsets: UIEdgeInsets = UIEdgeInsets()
    var avatarViewHeight: CGFloat = 60
    var cardsViewHeight: CGFloat = 0
    var categoryHeight: CGFloat = 120
    var tableViewHeight: CGFloat = 0
    var scrollViewContentH: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDiscoverMovies()

        view.backgroundColor = UIColor(named: "customBackground")
        tableView.dataSource = dataSource
        scrollView.delegate = self
        tableView.delegate = self
        cardsView.delegate = self
        categoryView.delegate = self
        
        
        let window = UIApplication.shared.windows[0]
        viewInsets = window.safeAreaInsets
        
        configureViews()

        createDataSource()
//        reloadData()
     

    }
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cardsView.setupScrollFirst()
    }
    
    private func fetchDiscoverMovies() {
        APICaller.shared.getDiscoverMovies() { [weak self] results in
            switch results {
                case.success(let movies):
                    print("1st request")
                    self?.movies =  movies
                    DispatchQueue.main.async {
                        self?.reloadData()
                        self?.cardsView.movies = self!.movies
                        self!.cardsView.reloadData()
                    }
                case.failure(let error):
                    print(error)
            }
        }
    }
  
    func configureViews() {
        
        cardsViewHeight = UIScreen.viewHeight * 0.4
        tableViewHeight = UIScreen.viewHeight - viewInsets.top - avatarViewHeight - categoryHeight

        scrollViewContentH = cardsViewHeight + categoryHeight + tableViewHeight - viewInsets.bottom
        
        view.addSubview(avatarView)
        view.addSubview(scrollView)
        
        scrollView.addSubview(cardsView)
        scrollView.addSubview(categoryView)
        scrollView.addSubview(tableView)
        
        setupAvatarView()
        setupScrollView()
        setupTableView()
        setupConstraints()
        
    }

    func setupAvatarView() {
    }
    
    func setupScrollView() {
        scrollView.frame = .zero
        scrollView.contentSize.height = scrollViewContentH
        scrollView.showsVerticalScrollIndicator = false
        scrollView.decelerationRate = .fast
    }
    
    func setupTableView() {
        tableView.register(FilmCell.self, forCellReuseIdentifier: FilmCell.reuseId)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.decelerationRate = .fast
        //tableView.backgroundColor = UIColor(named: "customBackground")
        
        createDataSource()
        reloadData()
        
    }
 // MARK: - DiffableDataSource
    func createDataSource(){
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { (tableView, indexPath, movie) -> UITableViewCell?  in
            let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell", for: indexPath) as? FilmCell
                cell?.configure(with: movie)
            return cell
        })
    }
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshot.appendSections([.mainFilms])
        snapshot.appendItems(movies, toSection: .mainFilms)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    func reloadDataRand() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshot.appendSections([.mainFilms])
        snapshot.appendItems(movies.shuffled(), toSection: .mainFilms)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
// MARK: - setup constraints
    
    func setupConstraints() {
        avatarView.snp.makeConstraints { make in
            make.width.equalTo(view)
            make.height.equalTo(avatarViewHeight)
            make.top.equalTo(view).offset(viewInsets.top)
            make.leading.equalTo(view)
        }
        scrollView.snp.makeConstraints { make in
            make.width.equalTo(view)
            make.leading.equalTo(view)
            make.top.equalTo(avatarView.snp.bottom)
            make.height.equalTo(UIScreen.viewHeight - avatarViewHeight - viewInsets.top)
        }
        
        cardsView.snp.makeConstraints { make in
            make.width.equalTo(view)
            make.height.equalTo(cardsViewHeight)
            make.top.equalTo(scrollView)

        }
        
        categoryView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
            make.height.equalTo(categoryHeight)
            make.top.equalTo(cardsView.snp.bottom)
            make.top.greaterThanOrEqualTo(avatarView.snp.bottom)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(categoryView.snp.bottom)
            make.width.equalTo(scrollView.snp.width)
            make.height.equalTo(tableViewHeight)
        }
        
    }


}
extension HomeVC {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        96
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
    
    
    func pushDetailVC(from indexPath: IndexPath) {
        let movies = movies[indexPath.row]
        DispatchQueue.main.async {
            let vc = DetailVC()
            let model = DetailMovieViewModel(id: movies.id, titleName: movies.title , posterURL: movies.poster_path ?? "", releaseDate: movies.release_date ?? "", voteAverage: movies.vote_average, overview: movies.overview ?? "" , runtime: movies.runtime ?? 0)
            vc.configure(with: model)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}



//
//  RecentVideoVC.swift
//  FilmFusion
//
//  Created by Alexandr Rodionov on 3.04.23.
//

import UIKit
import SnapKit
import RealmSwift

class RecentWatchViewController: UIViewController {
    
    private var recentWatchFilms: List<RealmFilm>!
    
    private var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor(named: "customBackground")
        return collectionView
    }()
    
    private var dataArray: [String] = ["All", "Action", "Adventure", "Mystery", "Fantasy", "Others"]
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recent Watch"
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.register(FilmTableViewCell.self, forCellReuseIdentifier: "FilmTableViewCell")
        collectionView.register(CatgoryCell.self, forCellWithReuseIdentifier: "Category Cell")
        setupView()
        recentWatchFilms = RealmDataBase.shared.readRecentWatch(category: "All")
        collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: [])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "customBackground")
        
        view.addSubview(collectionView)
        view.addSubview(tableView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(10)
            //make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(200)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
    }


}

//MARK: - UITableViewDelegate
extension RecentWatchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Тыкнули по ячейке в Recent Watch")
        let rev = Array(recentWatchFilms.reversed())
        let movie = rev[indexPath.row]
        let vc = DetailVC()
        vc.configureWithRealm(film: movie)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: - UITableViewDataSource
extension RecentWatchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(recentWatchFilms.count)
        return recentWatchFilms.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilmTableViewCell") as? FilmTableViewCell
            else { return UITableViewCell() }
        let reversedRecentWatchFilms = Array(recentWatchFilms.reversed())
        cell.delegate = self
        cell.configureWithRealm(film: reversedRecentWatchFilms[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180
    }
    
    
}

//MARK: - UICollectionViewDelegate
extension RecentWatchViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("тынули по ячейке номер \(indexPath.item)")
        
        switch indexPath.item {
        case 0: recentWatchFilms = RealmDataBase.shared.readRecentWatch(category: "All")
        case 1: recentWatchFilms = RealmDataBase.shared.readRecentWatch(category: "Action")
        case 2: recentWatchFilms = RealmDataBase.shared.readRecentWatch(category: "Adventure")
        case 3: recentWatchFilms = RealmDataBase.shared.readRecentWatch(category: "Mystery")
        case 4: recentWatchFilms = RealmDataBase.shared.readRecentWatch(category: "Fantasy")
        case 5: recentWatchFilms = RealmDataBase.shared.readRecentWatch(category: "Others")
        default: print("EEEEEERRRRRRROOOOOORRRRR!!!!")
        }
        tableView.reloadData()
    }
}

//MARK: - UICollectionViewDataSource
extension RecentWatchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Category Cell", for: indexPath) as? CatgoryCell else { return UICollectionViewCell() }
        
        cell.configure(text: dataArray[indexPath.item])
        return cell
    }
    


}

//MARK: - UICollectionViewDelegateFlowLayout
extension RecentWatchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = dataArray[indexPath.item]
        let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize: 14.0)]).width + 50.0
        return CGSize(width: cellWidth, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}



//MARK: - Cell delegate
extension RecentWatchViewController: FilmTableViewCellDelegate {
    func didTapFavoriteButton(onCell cell: FilmTableViewCell) {
        tableView.reloadData()
    }
}

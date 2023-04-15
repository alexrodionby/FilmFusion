//
//  FavoritesVC.swift
//  FilmFusion
//
//  Created by Alexandr Rodionov on 3.04.23.
//

import UIKit
import SnapKit
import RealmSwift

final class FavoritesViewController: UIViewController {
    
    private var films: List<RealmFilm>!
   
    private let tableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        films = RealmDataBase.shared.readFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

//MARK: - Setup UI
    private func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FilmTableViewCell.self, forCellReuseIdentifier: "FilmTableViewCell")
        title = "Favorites"
        view.backgroundColor = UIColor(named: "customBackground")
        view.addSubview(tableView)
        setupConstraints()
        setupNavCont()
    }
    
    private func setupNavCont() {
        navigationController?.navigationBar.barTintColor = .systemBackground
        navigationController?.navigationBar.shadowImage = UIImage()
        let deleteAllItems = UIBarButtonItem(
            image: UIImage(systemName: "trash.fill"),
            style: .plain,
            target: self,
            action: #selector(deleteAllButtonTapped))
        navigationItem.rightBarButtonItem = deleteAllItems
        deleteAllItems.tintColor = UIColor(named: "customMiniLabel")
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            //make.top.leading.trailing.bottom.equalToSuperview()
            
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    @objc private func deleteAllButtonTapped() {
        if films.isEmpty {
            let alert = UIAlertController(
                title: "Favorites is already empty",
                message: "",
                preferredStyle: .alert)
            let actionOK = UIAlertAction(
                title: "OK",
                style: .default)
            alert.addAction(actionOK)
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(
                title: "Clear favorites?",
                message: "",
                preferredStyle: .alert)
            let actionYes = UIAlertAction(
                title: "Yes",
                style: .destructive) { action in
                RealmDataBase.shared.deleteAll()
                self.tableView.reloadData()
            }
            let actionNo = UIAlertAction(
                title: "No",
                style: .cancel)
            alert.addAction(actionNo)
            alert.addAction(actionYes)
            present(alert, animated: true)
        }
    }
}

//MARK: - UITableViewDelegate
extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Тыкнули по ячейке")
        let rev = Array(films.reversed())
        let movie = rev[indexPath.row]
        let vc = DetailVC()
        vc.configureWithRealm(film: movie)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("КОЛИЧЕСТВО ЯЧЕЕК В ТАБЛИЦЕ: \(films.count)")
        return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilmTableViewCell") as? FilmTableViewCell
            else { return UITableViewCell() }
        let reversedFilms = Array(films.reversed())
        cell.delegate = self
        cell.configureWithRealm(film: reversedFilms[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180
    }
    
    
}

//MARK: - Cell delegate
extension FavoritesViewController: FilmTableViewCellDelegate {
    func didTapFavoriteButton(onCell cell: FilmTableViewCell) {
        tableView.reloadData()
    }
}

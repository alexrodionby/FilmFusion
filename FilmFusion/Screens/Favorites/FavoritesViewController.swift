//
//  FavoritesVC.swift
//  FilmFusion
//
//  Created by Alexandr Rodionov on 3.04.23.
//

import UIKit
import SnapKit

final class FavoritesViewController: UIViewController {
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

//MARK: - Setup UI
    private func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FilmTableViewCell.self, forCellReuseIdentifier: "FilmTableViewCell")
        title = "Favorites"
        view.backgroundColor = .white
        view.addSubview(tableView)
        setupConstraints()
        setupNavCont()
    }
    
    private func setupNavCont() {
        navigationController?.navigationBar.barTintColor = .systemBackground
        navigationController?.navigationBar.shadowImage = UIImage()
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


}

//MARK: - UITableViewDelegate
extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Тыкнули по ячейке")
    }
}

//MARK: - UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilmTableViewCell") as? FilmTableViewCell
            else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180
    }
    
    
}


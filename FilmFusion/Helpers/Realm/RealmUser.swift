//
//  RealmUser.swift
//  FilmFusion
//
//  Created by Ян Бойко on 07.04.2023.
//

import Foundation
import RealmSwift

class RealmUser: Object {
    @objc dynamic var uuid: String = ""
    let favoritesFilms = List<RealmFilm>()
    let recentWatchFilms = List<RealmFilm>()
}

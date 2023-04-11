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
    @objc dynamic var firstname: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var dateOfBirth: String = ""
    @objc dynamic var gender: String = ""
    @objc dynamic var profilePicture: Data = Data()
    let favoritesFilms = List<RealmFilm>()
    let recentWatchFilms = List<RealmFilm>()
}

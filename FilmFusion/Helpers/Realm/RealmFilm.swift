//
//  Film.swift
//  FilmFusion
//
//  Created by Ян Бойко on 05.04.2023.
//

import Foundation
import RealmSwift

class RealmFilm: Object {
    @objc dynamic var titleName: String = ""
    @objc dynamic var image: Data = Data()
//    @objc dynamic var imageURL: String = ""
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var voteAverage: Double = 0.0
    @objc dynamic var voteCount: Int = 0
//    @objc dynamic var runtime: Int
    @objc dynamic var category: String = "Action"
    var parentCategory = LinkingObjects(fromType: RealmUser.self, property: "favoritesFilms")
}

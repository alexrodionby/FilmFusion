//
//  RealmDataBase.swift
//  FilmFusion
//
//  Created by Ян Бойко on 05.04.2023.
//

import RealmSwift
import Foundation

class RealmDataBase {
    
    // MARK: - Properties
    
    static let shared = RealmDataBase()

    private let realm = try! Realm()
    private var items: List<RealmFilm>!
//    private var users: Results<RealmUser>!
    private lazy var realmUser: RealmUser = loadCurrentUserWith(email: "vasya.pupkin@mail.ru")
    
    // MARK: - Initialization
    
    private init() {
        print("Realm is located at:", realm.configuration.fileURL!)
    }
    
    // MARK: - Public methods
    
    func isItemSaved(withName titleName: String) -> Bool {
        let itemsWithName = realmUser.favoritesFilms.filter("titleName = %@", titleName)
        return !itemsWithName.isEmpty
    }
    
    func write(favoritesRealmFilm: RealmFilm) {
        try! realm.write({
            realmUser.favoritesFilms.append(favoritesRealmFilm)
        })
        
    }
    
    func write(recentWatchRealmFilm: RealmFilm) {
        try! realm.write({
            realmUser.recentWatchFilms.append(recentWatchRealmFilm)
        })
    }
    
//    func write(realmFilm: RealmFilm) {
//        try! self.realm.write({
//            self.realm.add(realmFilm)
//        })
        
//    }
    
    
    func createUserWith(uuid: String, firstName: String, lastName: String, email: String, dateOfBirth: String, gender: String, profilePicture: Data) {
        let newUser = RealmUser()
        newUser.uuid = uuid
        newUser.firstname = firstName
        newUser.lastName = lastName
        newUser.email = email
        newUser.dateOfBirth = dateOfBirth
        newUser.gender = gender
        newUser.profilePicture = profilePicture
        
        try! realm.write({
            self.realm.add(newUser)
            print("ЮЗЕР ДОБАВЛЕН ЕПТЫ БЛЯ")
        })
    }
    
//    func write(realmUser: RealmUser) {
//        try! realm.write({
//            self.realm.add(realmUser)
//        })
//    }
    
    func readFavorites() -> List<RealmFilm> {
        items = realmUser.favoritesFilms
        return items
    }
    
    func readRecentWatch(category: String) -> List<RealmFilm> {
        if category == "All" {
            items = realmUser.recentWatchFilms
        } else {
            let results = realmUser.recentWatchFilms.where {
                $0.category == category
            }
//            for i in results {
//                items.append(i)
//            }
            items = results.list
            //items = realmUser.recentWatchFilms.filter({ $0.category == category })
            
            
            //items = items.append(
            
//            where({ film in
//                film.category == category
//            })
        }
        
        return items
    }
    
//    func read() -> Results<RealmFilm> {
//        items = realm.objects(RealmFilm.self)
//        return items
//    }
    
    func deleteItem(withName titleName: String) {
        
        try! realm.write {
            let film = realmUser.favoritesFilms.where {
                $0.titleName == titleName
            }
            realm.delete(film)
        }
    }

    func deleteAll() {
        
        try! realm.write {
            let allFilms = realmUser.favoritesFilms
            realm.delete(allFilms)
        }
        
    }
    
//    func loadUsers() -> RealmUser { //Results<RealmUser>
//        let users = realm.objects(RealmUser.self)
//        return users.last!
//    }
    
    func loadCurrentUserWith(email: String) -> RealmUser {
        let users = realm.objects(RealmUser.self).where {
            $0.email == email
        }
        let currentUser = users.first ?? RealmUser()
        
        return currentUser
    }
}

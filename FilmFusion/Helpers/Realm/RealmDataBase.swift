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
    lazy var currentRealmUser: RealmUser = loadCurrentUserWith(email: "vasya.pupkin@mail.ru") // вот сюда добавить загрузку текущего юзера из firebase и взять у него email, если Саша email не хранит, то брать uuid и чуть чуть подправить реализацию метода, спросить у Саши какой метод я должен использовать для этого
    
    // MARK: - Initialization
    
    private init() {
        print("Realm is located at:", realm.configuration.fileURL!)
    }
    
    // MARK: - Public methods
    
    func isItemSaved(withName titleName: String) -> Bool {
        let itemsWithName = currentRealmUser.favoritesFilms.filter("titleName = %@", titleName)
        return !itemsWithName.isEmpty
    }
    
    func write(favoritesRealmFilm: RealmFilm) {
        try! realm.write({
            currentRealmUser.favoritesFilms.append(favoritesRealmFilm)
        })
        
    }
    
    func write(recentWatchRealmFilm: RealmFilm) {
        try! realm.write({
            currentRealmUser.recentWatchFilms.append(recentWatchRealmFilm)
        })
    }
    
//    func write(realmFilm: RealmFilm) {
//        try! self.realm.write({
//            self.realm.add(realmFilm)
//        })
        
//    }
    
    
    func createUserWith(uuid: String, firstName: String, lastName: String, email: String) {
        let newUser = RealmUser()
        newUser.uuid = uuid
        newUser.firstname = firstName
        newUser.lastName = lastName
        newUser.email = email
        
        try! realm.write({
            self.realm.add(newUser)
        })
    }
    
    func updateUserDataWith(uuid: String, firstName: String, lastName: String, email: String, dateOfBirth: String, gender: String, profilePicture: Data) {
        
        try! realm.write({
            currentRealmUser.uuid = uuid
            currentRealmUser.firstname = firstName
            currentRealmUser.lastName = lastName
            currentRealmUser.email = email
            currentRealmUser.dateOfBirth = dateOfBirth
            currentRealmUser.gender = gender
            currentRealmUser.profilePicture = profilePicture
        })
    }
    
//    func write(realmUser: RealmUser) {
//        try! realm.write({
//            self.realm.add(realmUser)
//        })
//    }
    
    func readFavorites() -> List<RealmFilm> {
        items = currentRealmUser.favoritesFilms
        return items
    }
    
    func readRecentWatch(category: String) -> List<RealmFilm> {
        if category == "All" {
            items = currentRealmUser.recentWatchFilms
        } else {
            let results = currentRealmUser.recentWatchFilms.where {
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
            let film = currentRealmUser.favoritesFilms.where {
                $0.titleName == titleName
            }
            realm.delete(film)
        }
    }

    func deleteAll() {
        
        try! realm.write {
            let allFilms = currentRealmUser.favoritesFilms
            realm.delete(allFilms)
        }
        
    }
    
//    func loadUsers() -> RealmUser { //Results<RealmUser>
//        let users = realm.objects(RealmUser.self)
//        return users.last!
//    }
    
    private func loadCurrentUserWith(email: String) -> RealmUser {
        let users = realm.objects(RealmUser.self).where {
            $0.email == email
        }
        let currentUser = users.first ?? RealmUser()
        
        return currentUser
    }
}

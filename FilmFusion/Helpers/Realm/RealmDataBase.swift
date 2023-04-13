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
    
    private var authUserUid = {
        do {
            let user = try AuthenticationManager.shared.getAuthenticatedUser()
            print(user.email)
            return user.uid
        } catch {
            print("Ошибка при аутентификации")
            return "0"
        }
    }
            
    var currentRealmUser: RealmUser {
        return loadCurrentUserWith(uuid: authUserUid())
    }
    
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
        
        let film = currentRealmUser.recentWatchFilms.where {
            $0.titleName == recentWatchRealmFilm.titleName
        }
        if film.isEmpty {
            try! realm.write({
                currentRealmUser.recentWatchFilms.append(recentWatchRealmFilm)
            })
        } else {
            try! realm.write({
                realm.delete(film)
                currentRealmUser.recentWatchFilms.append(recentWatchRealmFilm)
            })
        }
    }
    
    func createUserWith(uuid: String, firstName: String, lastName: String, email: String) {
        
        let users = realm.objects(RealmUser.self).where {
            $0.uuid == uuid
        }
        
        if let currentUser = users.first {
            return
        } else {
            let newUser = RealmUser()
            newUser.uuid = uuid
            newUser.firstname = firstName
            newUser.lastName = lastName
            newUser.email = email
            
            try! realm.write({
                self.realm.add(newUser)
            })
        }
        
        
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
    
    func readFavorites() -> List<RealmFilm> {
        items = currentRealmUser.favoritesFilms
        return items
    }
    
    func readRecentWatch(category: String) -> List<RealmFilm> { //метод нужно доделать, когда появятся категории в модели
        if category == "All" {
            items = currentRealmUser.recentWatchFilms
        } else {
            let results = currentRealmUser.recentWatchFilms.where {
                $0.category == category
            }
            items = results.list
        }
        
        return items //приложуха падает, если ничего нет в items
    }
    
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
    
    //MARK: - Private methods
    private func loadCurrentUserWith(uuid: String) -> RealmUser {
        let users = realm.objects(RealmUser.self).where {
            $0.uuid == uuid
        }
        let currentUser = users.first ?? RealmUser()
        return currentUser
    }
}

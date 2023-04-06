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
    private var items: Results<RealmFilm>!
    
    // MARK: - Initialization
    
    private init() {
        print("Realm is located at:", realm.configuration.fileURL!)
    }
    
    // MARK: - Public methods
    
    func isItemSaved(withName titleName: String) -> Bool {
        let itemsWithName = realm.objects(RealmFilm.self).filter("titleName = %@", titleName)
        return !itemsWithName.isEmpty
    }
    
    func write(realmFilm: RealmFilm) {
        try! self.realm.write({
            self.realm.add(realmFilm)
        })
        
    }
    
    func read() -> Results<RealmFilm> {
        items = realm.objects(RealmFilm.self)
        return items
    }
    
    func deleteitem(withName titleName: String) {
        
        try! realm.write {
            let film = realm.objects(RealmFilm.self).where {
                $0.titleName == titleName
            }
            realm.delete(film)
        }
    }

    func deleteAll() {
        
        try! realm.write {
            let allFilms = realm.objects(RealmFilm.self)
            realm.delete(allFilms)
        }
        
    }
}

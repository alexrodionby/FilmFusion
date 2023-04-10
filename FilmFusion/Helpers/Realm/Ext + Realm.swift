//
//  Ext + Realm.swift
//  FilmFusion
//
//  Created by Ян Бойко on 10.04.2023.
//

import Foundation
import RealmSwift

extension Results {
  var list: List<Element> {
    reduce(.init()) { list, element in
      list.append(element)
      return list
    }
  }
}

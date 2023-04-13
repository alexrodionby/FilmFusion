//
//  FilmModel.swift
//  AFMovie
//
//  Created by Alex F on 5.04.23.
//

import UIKit

struct Film: Hashable {
     let title: String
    let poster: UIImage?

 }

let filmsMy: [Film] = {
        var films = [Film]()
        for x in 0...21 {
            let posterImage = UIImage(named: "film\(x+1)")
            let film = Film(title: "My epselom erka surus Film \(x + 1)", poster: posterImage)
            films.append(film)
        }
        return films
    }()


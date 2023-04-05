//
//  Movie.swift
//  FilmFusion
//
//  Created by KODDER on 04.04.2023.
//

import UIKit

struct MovieResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
//    let runtime: Int?
}

struct MovieViewModel {
    let titleName: String
    let posterURL: String
    let releaseDate: String
    let voteAverage: Double
    let voteCount: Int
//    let runtime: Int
}

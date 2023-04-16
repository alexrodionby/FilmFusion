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

struct MovieCreditResponse: Codable {
    let cast: [MovieCast]
    let crew: [MovieCrew]
}

struct Movie: Codable, Hashable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    let media_type: String?
    let id: Int
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
    let runtime: Int?
    let video: Bool
    let genres: [MovieGenre]?
    let adult: Bool
    let backdrop_path: String?
    let budget: Int?
    let homepage: String?
    let original_language: String
    let production_companies: [ProductionCompanies]?
    let tagline: String?
    let title: String
    
    var unwrappedOriginalTitle: String {
        original_title ?? "no title"
    }
    var unwrappedPosterPath: String {
        poster_path ?? ""
    }
    var unwrappedRuntime: Int {
        runtime ?? 0
    }
    var unwrappedVoteCount: Int {
        vote_count ?? 0
    }
    var unwrappedVoteAverage: Double {
        vote_average ?? 0.0
    }
    var unwrappedGenres: [MovieGenre] {
        genres ?? [MovieGenre]()
    }
    
    var unwrappedRelease_date: String? {
        release_date ?? "no date"
    }

}


struct MovieCast: Codable {
    let id: Int
    let character: String
    let name: String
}

struct MovieCrew: Codable {
    let id: Int
    let job: String
    let name: String
}

struct MovieGenre: Codable {
    let id: Int
    let name: String
    
    var unvrappedName: String {
        name ?? "."
    }
}

struct ProductionCompanies: Codable {
    let name: String
    let id: Int
    let logo_path: String?
    let origin_country: String
}


struct DetailMovieViewModel {
    let id: Int
    let titleName: String
    let posterURL: String
    let releaseDate: String
    let voteAverage: Double
    let voteCount: Int
    let overview: String
    let runtime: Int
}

struct MovieViewModel {
    let id: Int
    let titleName: String
    let posterURL: String
    let releaseDate: String
    let voteAverage: Double
    let voteCount: Int
    let runtime: Int
}

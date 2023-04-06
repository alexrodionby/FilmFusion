//
//  APICaller.swift
//  FilmFusion
//
//  Created by KODDER on 04.04.2023.
//

import UIKit

struct Constants {
    static let API_KEY = "75707bcf3f52a789b5dc3dee9cf12032"
    static let baseURL = "https://api.themoviedb.org"
}

enum APIError: Error {
    case failedTogetData
}

class APICaller {
    static let shared = APICaller()
    
    func getMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
//    func getDetailsMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
//        guard let url = URL(string: "\(Constants.baseURL)/3/movie?api_key=\(Constants.API_KEY)") else {return}
//        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
//            guard let data = data, error == nil else {
//                return
//            }
//            
//            do {
//                let results = try JSONDecoder().decode(MovieResponse.self, from: data)
//                completion(.success(results.results))
//            } catch {
//                completion(.failure(APIError.failedTogetData))
//            }
//        }
//        task.resume()
//    }
//    
}

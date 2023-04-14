//
//  APICaller.swift
//  FilmFusion
//
//  Created by KODDER on 04.04.2023.
//

import UIKit

struct Constants {
   // static let API_KEY = "75707bcf3f52a789b5dc3dee9cf12032"
    static let API_KEY = "49145d8f1ff00f3f57c691a024347d25"
    static let baseURL = "https://api.themoviedb.org"
    static let youtubeAPI_KEY = "AIzaSyBWyZFNkH0svO3KnavYVIz9qMHhWB29Un4"
    static let youtubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
    static let genres: [String : String] = ["Action" : "28", "Adventure" : "12", "Animation" : "16", "Comedy" : "35", "Crime" : "80", "Documentary" : "99", "Drama" : "18", "Family" : "10751", "Fantasy" : "14", "History" : "36", "Horror" : "27", "Music" : "10402", "Mystery" : "9648", "Romance" : "10749", "Science Fiction" : "878", "TV Movie" : "10770", "Thriller" : "53", "War" : "10752", "Western" : "37"]
}

enum APIError: Error {
    case failedTogetData
}

class APICaller {
    static let shared = APICaller()
    
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
    
    func searchByGenre(with query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=\(Constants.genres[query] ?? "28")&with_watch_monetization_types=flatrate") else {return}
        print("URL =", url)
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(results.results))
                print("Запрос жанров работает")
                print(results.results)
            } catch {
                completion(.failure(APIError.failedTogetData))
                print("Запрос жанров НЕ работает")
            }
        }
        task.resume()
    }
    
    //Запрос на детали фильма (здесь как раз есть "runtime" и жанры и кастеры)
    func getDetailsMovies(id: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/\(id)?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(results.results))
                print(results)
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func search(with query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else {return}
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
    
    //YOUTUBE
    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(Constants.youtubeBaseURL)?q=\(query)&key=\(Constants.youtubeAPI_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion(.success(results.items[0]))
                
            } catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}

//
//  NetworkRequest.swift
//  Movies
//
//  Created by Сергей Анпилогов on 26.10.2022.
//

import Foundation


struct Constants {
    static let apiKey = "08e8119e4bf4b11a0e579aaaad7bd3ce"
    static let url = "https://api.themoviedb.org"
}

///3/now_playing/tv/day?api_key=
class NetworkRequest {
    
    static let shared = NetworkRequest()
    
    private init() {}
    
    func getTrendingMovies(complection: @escaping (Result<[Movie], Error>) -> Void) {
    
        guard let url = URL(string: "\(Constants.url)/3/movie/popular?api_key=\(Constants.apiKey)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results =  try JSONDecoder().decode(MoviesResponse.self, from: data)
                complection(.success(results.results))
                
            } catch {
                complection(.failure(error))
            }
        }
        task.resume()
     }
    
   
    
    func getUpComingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.url)/3/movie/upcoming?api_key=\(Constants.apiKey)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_, error in
            guard let data = data , error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(MoviesResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getTopRatedMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.url)/3/movie/top_rated?api_key=\(Constants.apiKey)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_, error in
            guard let data = data , error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(MoviesResponse.self, from: data)
        
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

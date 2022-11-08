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
    static let youTubeApi_Key = "AIzaSyBPYMxb71Rc4hSfkk9j5pboQtX85B6tw94"
    static let youTubeUrl = "https://youtube.googleapis.com/youtube/v3/search?"
}

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

    func getMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.url)/3/discover/movie?api_key=\(Constants.apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_, error in
            guard let data = data , error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(MoviesResponse.self, from: data)
        
                completion(.success(results.results))
                print(results)
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    

    func getTvShow(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.url)/3/discover/tv?api_key=\(Constants.apiKey)&language=en-US&sort_by=popularity.desc&page=1&timezone=America%2FNew_York&include_null_first_air_dates=false&with_watch_monetization_types=flatrate&with_status=0&with_type=0") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_, error in
            guard let data = data , error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(MoviesResponse.self, from: data)
        
                completion(.success(results.results))
                print(results)
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }

    
    func searchMovies(query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        
     guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(Constants.url)/3/search/movie?api_key=\(Constants.apiKey)&query=\(query)")  else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_, error in
            guard let data = data , error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(MoviesResponse.self, from: data)
        
                completion(.success(results.results))
                print(results)
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getMovie(query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
        
     guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        guard let url = URL(string: "\(Constants.youTubeUrl)q=\(query)&key=\(Constants.youTubeApi_Key)")  else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_, error in
            guard let data = data , error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(VideoSearchResponse.self, from: data)
                completion(.success(results.items[0]))
            } catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}


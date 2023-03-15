//
//  CoreDataManager.swift
//  Movies
//
//  Created by Сергей Анпилогов on 03.12.2022.
//

import UIKit
import RealmSwift

class RealmManager {
    
    enum DatabaseError: Error {
        case failedSaveData
        case failedfetchData
        case failedToDeleteData
    }
    
    static let shared = RealmManager()
    
    func donwloadTitlewitch(model: Movie, completion: @escaping (Result<Void, Error>) -> Void) {
        let realm = try! Realm()
        let item = MovieTitleRealm()
        
        item.id = model.id // установка значения id
        
        item.original_title = model.original_title ?? ""
        item.original_name = model.original_name ?? ""
        item.overview = model.overview ?? ""
        item.media_type = model.media_type ?? ""
        item.poster_path = model.poster_path ?? ""
        item.vote_count = model.vote_count
        item.release_date = model.release_data ?? ""
        
        do {
            try realm.write {
                realm.add(item, update: .all)
            }
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failedSaveData))
        }
    }
    
    func fetchingMovieFromDataBase(completion: @escaping (Result<[MovieTitleRealm], Error>) -> Void) {
        let realm = try! Realm()
        let movies = realm.objects(MovieTitleRealm.self).toArray()
        completion(.success(movies))
    }
    
    func deleteMovie(model: MovieTitleRealm, completion: @escaping (Result<Void, Error>) -> Void) {
        let realm = try! Realm()
        
        do {
            try realm.write {
                realm.delete(model)
            }
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failedToDeleteData))
        }
    }
}

extension Results {
    func toArray() -> [Element] {
        return compactMap { $0 }
    }
}

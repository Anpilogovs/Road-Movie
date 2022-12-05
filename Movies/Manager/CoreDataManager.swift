//
//  CoreDataManager.swift
//  Movies
//
//  Created by Сергей Анпилогов on 03.12.2022.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    enum DatabaseError: Error {
        case failedSaveData
        case failedfetchData
        case failedToDeleteData
    }
    
    
    static let shared = CoreDataManager()
    
    
    func donwloadTitlewitch(model: Movie, completion: @escaping (Result<Void, Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    
        let context = appDelegate.persistentContainer.viewContext
        let item = MovieTitle(context: context)
        
        item.original_title = model.original_title
        item.id = Int64(model.id)
        item.original_name = model.original_name
        item.overview = model.overview
        item.media_type = model.media_type
        item.poster_path = model.poster_path
        item.vote_count = Int64(model.vote_count)
        item.release_date = model.release_data
        item.vote_average = model.vote_average

    
        do {
                try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failedSaveData))
        }
    }
    
    func fetchingMovieFromDataBase(completion: @escaping (Result<[MovieTitle], Error>) -> Void) {
        
        guard let appleDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appleDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<MovieTitle>
        request = MovieTitle.fetchRequest()
        
        do {
            let movie = try context.fetch(request)
            completion(.success(movie))
        } catch {
            completion(.failure(DatabaseError.failedfetchData))
        }
    }
    
    func deleteMovie(model: MovieTitle, completion: @escaping (Result<Void, Error>) -> Void) {
        
        guard let appleDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appleDelegate.persistentContainer.viewContext
        context.delete(model)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failedToDeleteData))
        }
    }
}

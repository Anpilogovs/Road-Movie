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
}

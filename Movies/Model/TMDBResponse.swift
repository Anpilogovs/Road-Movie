//
//  File.swift
//  Movies
//
//  Created by Сергей Анпилогов on 26.10.2022.
//

import Foundation


//создали модель  которая принимает всю информацию которую мы передадит на контроллер
struct MoviesResponse: Codable {
    
    let results: [Movie]
    
}

struct Movie: Codable {
    
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_data: String?
    let vote_average: Double
}


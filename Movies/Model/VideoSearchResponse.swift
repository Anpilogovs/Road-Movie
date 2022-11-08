//
//  VideoSearchResults.swift
//  Movies
//
//  Created by Сергей Анпилогов on 03.11.2022.
//

import Foundation


struct VideoSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String?
    let videoId: String?
}

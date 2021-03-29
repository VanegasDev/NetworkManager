//
//  Items.swift
//  NetworkManager
//
//  Created by Mario Vanegas on 3/27/21.
//

import Foundation

struct Movie: Decodable {
    let title: String
    let posterPath: String?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}

struct TVShow: Decodable {
    let title: String
    let posterPath: String?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "name"
        case posterPath = "poster_path"
        case releaseDate = "first_air_date"
    }
}

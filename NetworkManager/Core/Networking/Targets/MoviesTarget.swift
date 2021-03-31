//
//  MoviesTarget.swift
//  NetworkManager
//
//  Created by Applaudo on 3/29/21.
//

import Foundation

enum MoviesTarget {
    case fetchUpcoming(page: Int)
}

// MARK: Our Implementation
extension MoviesTarget: TMDBTargetType {
    var requestEndpoint: String {
        switch self {
        case .fetchUpcoming:
            return "/movie/upcoming"
        }
    }
    
    var requestMethod: TMDBNetworkMethod {
        switch self {
        case .fetchUpcoming:
            return .get
        }
    }
}

// MARK: URLSession Implementation
extension MoviesTarget {
    var queryParams: [String : String?] {
        [
            "api_key": Constants.apiKey,
            "page": "1"
        ]
    }
}

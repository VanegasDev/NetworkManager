//
//  TVShowsTarget.swift
//  NetworkManager
//
//  Created by Applaudo on 3/29/21.
//

import Foundation

enum TVShowsTarget {
    case fetchPopular(page: Int)
}

// MARK: Our Implementation
extension TVShowsTarget: TMDBTargetType {
    var requestEndpoint: String {
        switch self {
        case .fetchPopular:
            return "/tv/popular"
        }
    }
    
    var requestMethod: TMDBNetworkMethod {
        switch self {
        case .fetchPopular:
            return .get
        }
    }
}

// MARK: URLSession Implementation
extension TVShowsTarget {
    var queryParams: [String : String?] {
        [
            "api_key": Constants.apiKey,
            "page": "1"
        ]
    }
}

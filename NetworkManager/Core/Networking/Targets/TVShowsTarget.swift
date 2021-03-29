//
//  TVShowsTarget.swift
//  NetworkManager
//
//  Created by Applaudo on 3/29/21.
//

import Foundation
import Moya

enum TVShowsTarget {
    case fetchPopular(page: Int)
}

// MARK: Moya Implementation
extension TVShowsTarget: TMDBTargetType {
    var path: String {
        switch self {
        case .fetchPopular:
            return "/tv/popular"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchPopular:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .fetchPopular(let page):
            let params: [String: Any] = [
                "api_key": Constants.apiKey,
                "page": page
            ]
            
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
}

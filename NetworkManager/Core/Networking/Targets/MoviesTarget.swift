//
//  MoviesTarget.swift
//  NetworkManager
//
//  Created by Applaudo on 3/29/21.
//

import Foundation
import Moya

enum MoviesTarget {
    case fetchUpcoming(page: Int)
}

// MARK: Moya Implementation
extension MoviesTarget: TMDBTargetType {
    var path: String {
        switch self {
        case .fetchUpcoming:
            return "/movie/upcoming"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchUpcoming:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .fetchUpcoming(let page):
            let params: [String: Any] = [
                "api_key": Constants.apiKey,
                "page": page
            ]
            
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
}

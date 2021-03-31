//
//  NetworkConfiguration.swift
//  NetworkManager
//
//  Created by Applaudo on 3/29/21.
//

import Foundation

// MARK: TMDB Target Protocols
enum TMDBNetworkMethod: String {
    case post = "POST"
    case put = "PUT"
    case get = "GET"
    case delete = "DELETE"
    case patch = "PATCH"
}

protocol TMDBTargetType: URLSessionTarget {
    var apiURL: URL { get }
    var requestEndpoint: String { get }
    var requestHeaders: [String: String]? { get }
    var requestMethod: TMDBNetworkMethod { get }
}

// MARK: Our Target Implementation
extension TMDBTargetType {
    var apiURL: URL {
        guard let url = URL(string: Constants.baseURL) else {
            fatalError("Base URL Couldn't be Configured")
        }
        
        return url
    }
    
    var requestHeaders: [String: String]? {
        ["Content-Type": "application/json"]
    }
}


// MARK: Protocol for handling URL Session Requests
protocol URLSessionTarget {
    var queryParams: [String: String?] { get }
}

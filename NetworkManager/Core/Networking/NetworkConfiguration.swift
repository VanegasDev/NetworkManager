//
//  NetworkConfiguration.swift
//  NetworkManager
//
//  Created by Applaudo on 3/29/21.
//

import Foundation
import Moya

enum TMDBNetworkMethod: String {
    case post = "POST"
    case put = "PUT"
    case get = "GET"
    case delete = "DELETE"
    case patch = "PATCH"
}

protocol TMDBTargetType: TargetType {
    var apiURL: URL { get }
    var requestEndpoint: String { get }
    var requestHeaders: [String: String]? { get }
    var requestMethod: TMDBNetworkMethod { get }
}

// MARK: Our Implementation
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

// MARK: Moya Implementation
extension TMDBTargetType {
    var baseURL: URL {
        apiURL
    }
    
    var method: Moya.Method {
        switch requestMethod {
        case .delete: return .delete
        case .post: return .post
        case .get: return .get
        case .patch: return .patch
        case .put: return .put
        }
    }
    
    var headers: [String : String]? {
        requestHeaders
    }
    
    var path: String {
        requestEndpoint
    }
    
    var validationType: ValidationType {
        .successCodes
    }
    
    var sampleData: Data {
        Data()
    }
}

//
//  NetworkConfiguration.swift
//  NetworkManager
//
//  Created by Applaudo on 3/29/21.
//

import Foundation
import Moya

protocol TMDBTargetType: TargetType {}

// MARK: Moya Implementation
extension TMDBTargetType {
    var baseURL: URL {
        guard let url = URL(string: Constants.baseURL) else {
            fatalError("Base URL Couldn't be Configured")
        }
        
        return url
    }
    
    var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }
    
    var validationType: ValidationType {
        .successCodes
    }
    
    var sampleData: Data {
        Data()
    }
}

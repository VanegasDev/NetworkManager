//
//  APIResponse.swift
//  NetworkManager
//
//  Created by Applaudo on 3/29/21.
//

import Foundation

struct APIResponse<T: Decodable>: Decodable {
    let page: Int
    let results: [T]
}

//
//  NetworkManager.swift
//  NetworkManager
//
//  Created by Applaudo on 3/29/21.
//

import Foundation
import Combine

typealias NetworkResponse = (data: Data, httpResponse: HTTPURLResponse?)
typealias DecodedResponse<T: Decodable> = (response: T, httpResponse: HTTPURLResponse?)

protocol NetworkManagerType {
    func request(_ target: TMDBTargetType) -> AnyPublisher<NetworkResponse, Error>
}

extension NetworkManagerType {
    func request<T: Decodable>(_ target: TMDBTargetType, using decoder: JSONDecoder = .init()) -> AnyPublisher<DecodedResponse<T>, Error> {
        request(target)
            .tryMap { response in
                let decodedResponse = try decoder.decode(T.self, from: response.data)
                return (response: decodedResponse, httpResponse: response.httpResponse)
            }
            .eraseToAnyPublisher()
    }
    
    func request<T: Decodable>(_ target: TMDBTargetType, using decoder: JSONDecoder = .init()) -> AnyPublisher<T, Error> {
        request(target)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}

// MARK: Moya Manager
struct NetworkManager: NetworkManagerType {
    private let moyaRequester: MoyaRequesterType
    
    init(with moyaRequester: MoyaRequesterType = MoyaRequester()) {
        self.moyaRequester = moyaRequester
    }
    
    func request(_ target: TMDBTargetType) -> AnyPublisher<NetworkResponse, Error> {
        moyaRequester.request(target)
            .map { (data: $0.data, httpResponse: $0.response) }
            .eraseToAnyPublisher()
    }
}

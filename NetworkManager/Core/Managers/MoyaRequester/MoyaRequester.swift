//
//  MoyaRequester.swift
//  NetworkManager
//
//  Created by Applaudo on 3/29/21.
//

import Foundation
import Moya
import Combine

protocol MoyaRequesterType {
    func request(_ target: TargetType) -> AnyPublisher<Moya.Response, Error>
}

struct MoyaRequester: MoyaRequesterType {
    private let provider: MoyaProvider<MultiTarget>
    
    init(with provider: MoyaProvider<MultiTarget> = MoyaProvider()) {
        self.provider = provider
    }
    
    func request(_ target: TargetType) -> AnyPublisher<Moya.Response, Error> {
        Future { seal in
            provider.request(MultiTarget(target)) { networkResponse in
                switch networkResponse {
                case .failure(let error):
                    seal(.failure(error))
                case .success(let response):
                    seal(.success(response))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}


extension MoyaRequesterType {
    func request<T: Decodable>(_ target: TMDBTargetType, using decoder: JSONDecoder = .init()) -> AnyPublisher<DecodedResponse<T>, Error> {
        request(target)
            .tryMap { response in
                let decodedResponse = try decoder.decode(T.self, from: response.data)
                return (response: decodedResponse, httpResponse: response.response)
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

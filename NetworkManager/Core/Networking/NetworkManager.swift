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

// MARK: Our Network Manager, he only knows about our target
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

// MARK: Custom Errors - Just for URLSession in this case
enum NetworkError: LocalizedError {
    case invalidURL(URL?)
    case requestError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL(let url):
            return "Unreachable URL: \(url?.absoluteString ?? "")"
        case .requestError(let description):
            return description
        }
    }
}

// MARK: Example Using URLSession
struct NetworkManager: NetworkManagerType {
    private let apiRequester: URLSession
    
    init(with apiRequester: URLSession = .shared) {
        self.apiRequester = apiRequester
    }
    
    func request(_ target: TMDBTargetType) -> AnyPublisher<NetworkResponse, Error> {
        let url = target.apiURL.appendingPathComponent(target.requestEndpoint)
        let params = target.queryParams
        var request: URLRequest
        var myURL = URLComponents(string: url.absoluteString)
        var items: [URLQueryItem] = []

        for (key, value) in params {
            items.append(URLQueryItem(name: key, value: value))
        }

        myURL?.queryItems = items
        
        guard let requestURL = myURL?.url else { return Fail(error: NetworkError.invalidURL(myURL?.url)).eraseToAnyPublisher() }
        request = URLRequest(url: requestURL)
        request.allHTTPHeaderFields = target.requestHeaders
        request.httpMethod = target.requestMethod.rawValue
        
        return apiRequester.dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .map { (data: $0.data, httpResponse: $0.response as? HTTPURLResponse) }
            .mapError { NetworkError.requestError($0.localizedDescription) }
            .eraseToAnyPublisher()
    }
}

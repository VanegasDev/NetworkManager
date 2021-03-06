//
//  MoviesService.swift
//  NetworkManager
//
//  Created by Applaudo on 3/29/21.
//

import Foundation
import Combine

protocol MoviesServiceType {
    func fetchUpcomingMovies(page: Int) -> AnyPublisher<APIResponse<Movie>, Error>
}

struct MoviesService: MoviesServiceType {
    private let apiRequester: NetworkManagerType
    
    init(with apiRequester: NetworkManagerType = NetworkManager()) {
        self.apiRequester = apiRequester
    }
    
    func fetchUpcomingMovies(page: Int) -> AnyPublisher<APIResponse<Movie>, Error> {
        apiRequester.request(MoviesTarget.fetchUpcoming(page: page))
    }
}

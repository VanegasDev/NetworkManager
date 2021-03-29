//
//  TVShowsService.swift
//  NetworkManager
//
//  Created by Applaudo on 3/29/21.
//

import Foundation
import Combine

protocol TVShowsServiceType {
    func fetchPopularShows(page: Int) -> AnyPublisher<APIResponse<TVShow>, Error>
}

struct TVShowsService: TVShowsServiceType {
    private let apiRequester: MoyaRequesterType
    
    init(with apiRequester: MoyaRequesterType = MoyaRequester()) {
        self.apiRequester = apiRequester
    }
    
    func fetchPopularShows(page: Int) -> AnyPublisher<APIResponse<TVShow>, Error> {
        apiRequester.request(TVShowsTarget.fetchPopular(page: page))
    }
}

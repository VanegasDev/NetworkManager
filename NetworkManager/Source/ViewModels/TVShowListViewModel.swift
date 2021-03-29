//
//  TVShowListViewModel.swift
//  NetworkManager
//
//  Created by Applaudo on 3/29/21.
//

import SwiftUI
import Combine

class TVShowListViewModel: ObservableObject {
    @Published var showList: [ItemViewModel] = []
    
    private let service: TVShowsServiceType = TVShowsService()
    private var cancellables = Set<AnyCancellable>()
    
    func fetchShowList() {
        guard showList.isEmpty else { return }
        
        service.fetchPopularShows(page: 1)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("ERROR: \(error)")
                case .finished:
                    print("SUCCESS")
                }
            } receiveValue: { [weak self] apiResponse in
                self?.showList = apiResponse.results
                    .map {
                        ItemViewModel(url: URL(string: "\(Constants.imagePath)\($0.posterPath ?? "")"),
                                      title: $0.title,
                                      releaseDate: $0.releaseDate ?? "")
                    }
            }
            .store(in: &cancellables)
    }
}

//
//  MovieListViewModel.swift
//  NetworkManager
//
//  Created by Applaudo on 3/29/21.
//

import SwiftUI
import Combine

class MovieListViewModel: ObservableObject {
    @Published var movieList: [ItemViewModel] = []
    
    private let service: MoviesServiceType = MoviesService()
    private var cancellables = Set<AnyCancellable>()
    
    func fetchMovieList() {
        guard movieList.isEmpty else { return }
        
        service.fetchUpcomingMovies(page: 1)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("ERROR: \(error)")
                case .finished:
                    print("SUCCESS")
                }
            } receiveValue: { [weak self] apiResponse in
                self?.movieList = apiResponse.results
                    .map {
                        ItemViewModel(url: URL(string: "\(Constants.imagePath)\($0.posterPath ?? "")"),
                                      title: $0.title,
                                      releaseDate: $0.releaseDate ?? "")
                    }
            }
            .store(in: &cancellables)
    }
}

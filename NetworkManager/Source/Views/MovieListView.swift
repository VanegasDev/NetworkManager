//
//  MovieListView.swift
//  NetworkManager
//
//  Created by Applaudo on 3/29/21.
//

import SwiftUI

struct MovieListView: View {
    @StateObject var viewModel = MovieListViewModel()
    
    var body: some View {
        TMDBVerticalGrid(data: viewModel.movieList, spacing: 16) { item in
            ItemView(viewModel: item)
                .frame(height: 250)
        }
        .padding()
        .navigationBarTitle("Movies", displayMode: .inline)
        .onAppear(perform: viewModel.fetchMovieList)
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}

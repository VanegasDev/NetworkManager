//
//  TVShowListView.swift
//  NetworkManager
//
//  Created by Applaudo on 3/29/21.
//

import SwiftUI

struct TVShowListView: View {
    @StateObject var viewModel = TVShowListViewModel()
    
    var body: some View {
        TMDBVerticalGrid(data: viewModel.showList, spacing: 16) { item in
            ItemView(viewModel: item)
                .frame(height: 250)
        }
        .padding()
        .navigationBarTitle("TVShows", displayMode: .inline)
        .onAppear(perform: viewModel.fetchShowList)
    }
}

struct TVShowListView_Previews: PreviewProvider {
    static var previews: some View {
        TVShowListView()
    }
}

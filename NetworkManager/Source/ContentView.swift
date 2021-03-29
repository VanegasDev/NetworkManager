//
//  ContentView.swift
//  NetworkManager
//
//  Created by Mario Vanegas on 3/27/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Form {
                NavigationLink("Movies", destination: MovieListView())
                NavigationLink("TVShows", destination: TVShowListView())
            }
            .navigationBarTitle("TheMoveDB")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ItemView.swift
//  NetworkManager
//
//  Created by Mario Vanegas on 3/27/21.
//

import SwiftUI
import Kingfisher

class ItemViewModel: ObservableObject, Identifiable {
    let id = UUID()
    let url: URL?
    let title: String
    let releaseDate: String
    
    init(url: URL?, title: String, releaseDate: String) {
        self.url = url
        self.title = title
        self.releaseDate = DateFormatter.tmdbDatePreviewFormat(from: releaseDate)
    }
}

struct ItemView: View {
    @ObservedObject var viewModel: ItemViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            KFImage(viewModel.url)
                .resizable()
                .aspectRatio(163/180, contentMode: .fit)
                .fixedSize(horizontal: false, vertical: true)
            VStack(alignment: .leading, spacing: 0) {
                Text("\(viewModel.title)")
                    .fontWeight(.bold)
                    .font(.system(size: 17))
                Text("\(viewModel.releaseDate)")
                    .font(.system(size: 13))
            }
            .padding()
        }
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ItemViewModel(url: URL(string: "https://live.staticflickr.com/5613/15776135205_6d5257d138_b.jpg"),
                                      title: "Godzilla",
                                      releaseDate: "2021-06-09")
        return ItemView(viewModel: viewModel)
    }
}

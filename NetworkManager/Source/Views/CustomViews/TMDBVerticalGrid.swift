//
//  TMDBVerticalGrid.swift
//  NetworkManager
//
//  Created by Applaudo on 3/29/21.
//

import SwiftUI

struct TMDBVerticalGrid<Item, Content>: View where Item: RandomAccessCollection, Item.Element: Identifiable, Content: View {
    private let data: Item
    private let spacing: CGFloat?
    private let itemsConfiguration: [GridItem]
    private let completion: (Item.Element) -> Content
    
    init(data: Item, spacing: CGFloat? = nil, itemsConfiguration: [GridItem] = defaultConfiguration, @ViewBuilder completion: @escaping (Item.Element) -> Content) {
        self.data = data
        self.spacing = spacing
        self.itemsConfiguration = itemsConfiguration
        self.completion = completion
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: itemsConfiguration, spacing: spacing) {
                ForEach(data) { item in
                    completion(item)
                }
            }
        }
    }
}

extension TMDBVerticalGrid {
    static var defaultConfiguration: [GridItem] {
        [ GridItem(.flexible(minimum: 16)), GridItem(.flexible(minimum: 16)) ]
    }
}

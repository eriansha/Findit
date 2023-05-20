//
//  HomeView.swift
//  Findit
//
//  Created by Ivan on 20/05/23.
//

import SwiftUI

struct HomeView: View {
    
    private let items: [Item] = [
        Item(
            id: UUID(),
            logo: "🎒",
            name: "Bag",
            beaconUUID: UUID(),
            beaconMajor: 10,
            beaconMinor: 20
        ),
        Item(
            id: UUID(),
            logo: "🔑",
            name: "Key",
            beaconUUID: UUID(),
            beaconMajor: 10,
            beaconMinor: 20
        )
    ]
    
    private let adaptiveColums = [
        GridItem(.adaptive(minimum: 171))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: adaptiveColums, spacing: 16) {
                ForEach(items, id: \.self) { item in
                    ItemCard(item: item)
                }
                
                AddCard()
            }
        }.padding(.horizontal, 16)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

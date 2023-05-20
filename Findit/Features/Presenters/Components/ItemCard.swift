//
//  ItemCard.swift
//  Findit
//
//  Created by Ivan on 20/05/23.
//

import SwiftUI

struct ItemCard: View {
    public var item: Item
    
    @State private var showOptions: Bool = false
    @State private var navigateToDetecionView: Bool = false
    
    var body: some View {
        VStack {
            Button {
                showOptions.toggle()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: Theme.CornerRadius.large)
                        .fill(Theme.Colors.gray500)
                        .frame(width: 171, height: 171)
                    
                    VStack {
                        Text(item.logo)
                            .font(Theme.FontSize.xxlarge)
                        Text(item.name)
                            .foregroundColor(.black)
                    }
                }
            }.confirmationDialog(
                "Select action",
                isPresented: $showOptions,
                titleVisibility: .hidden) {
                    NavigationLink("Find Item", value: item)
                    
                    Button("Delete item", role: .destructive) {
                        print("Delete item")
                    }
            }
        }
        .navigationDestination(for: Item.self) { selectedItem in
            DetectionView(item: selectedItem)
        }
    }
}

struct ItemCard_Previews: PreviewProvider {
    static var dummyItem: Item = Item(
        id: UUID(),
        logo: "🎒",
        name: "Bag",
        beaconUUID: UUID(),
        beaconMajor: 10,
        beaconMinor: 20
    )
    
    static var previews: some View {
        ItemCard(item: dummyItem)
    }
}

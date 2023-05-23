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
                        if let logo = item.logo {
                            Text(logo)
                                .font(Theme.FontSize.xxlarge)
                        } else {
                            Text("📦")
                                .font(Theme.FontSize.xxlarge)
                        }
                        
                        if let name = item.name {
                            Text(name)
                                .foregroundColor(.black)
                        } else {
                            Text("-")
                                .foregroundColor(.black)
                        }
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
    static var previews: some View {
        ItemCard(item: FinditController.example)
    }
}

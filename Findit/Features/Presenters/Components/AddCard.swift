//
//  AddCard.swift
//  Findit
//
//  Created by Ivan on 20/05/23.
//

import SwiftUI

struct AddCard: View {
    @State private var showSheet: Bool = false
    
    var body: some View {
        Button {
            showSheet.toggle()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: Theme.CornerRadius.large)
                    .fill(Theme.Colors.gray500)
                    .frame(width: 171, height: 171)
                
                VStack {
                    Image(systemName: "plus.circle.fill")
                        .font(Theme.FontSize.xlarage)
                        .foregroundColor(.blue)
                    
                    Text("Add Item")
                        .foregroundColor(.black)
                }
            }
        }.sheet(isPresented: $showSheet) {
            AddItemForm()
        }
    }
}

struct AddCard_Previews: PreviewProvider {
    static var previews: some View {
        AddCard()
    }
}

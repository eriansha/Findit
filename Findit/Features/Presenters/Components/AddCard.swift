//
//  AddCard.swift
//  Findit
//
//  Created by Ivan on 20/05/23.
//

import SwiftUI

struct AddCard: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Theme.CornerRadius.large)
                .fill(Theme.Colors.gray500)
                .frame(width: 171, height: 171)
            
            VStack {
                Image(systemName: "plus.circle.fill")
                    .font(Theme.FontSize.xlarage)
                    .foregroundColor(.blue)
                
                Text("Add Item")
            }
        }
    }
}

struct AddCard_Previews: PreviewProvider {
    static var previews: some View {
        AddCard()
    }
}

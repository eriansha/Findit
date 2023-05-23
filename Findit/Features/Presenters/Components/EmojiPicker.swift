//
//  EmojiPicker.swift
//  Findit
//
//  Created by Ivan on 23/05/23.
//

import SwiftUI

struct EmojiPicker: View {
    @EnvironmentObject var errorData: ErrorData
    
    public var name: String = ""
    @Binding var emoji: String
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Theme.Colors.gray500)
                    .frame(width: 150, height: 150)
                
                Button {
                    isPresented.toggle()
                } label: {
                    VStack {
                        if emoji.isEmpty {
                            Image(systemName: "face.dashed")
                                .foregroundColor(.gray)
                                .font(Theme.FontSize.large)
                                .padding(.bottom, 1)
                            Text("Select Emoji")
                                .font(.caption)
                                .foregroundColor(.gray)
                        } else {
                            Text(emoji)
                                .font(Theme.FontSize.xlarage)
                        }
                    }
                }.sheet(isPresented: $isPresented) {
                    EmojiSheet(emoji: $emoji, isPresented: $isPresented)
                        .padding()
                        .presentationDetents([.height(400), .medium, .large])
                        .presentationDragIndicator(.automatic)
                        .padding(.top, 32)
                        .edgesIgnoringSafeArea(.bottom)
                    //.frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            
            if let error = errorData.errorFields.first(where: { $0.key == name })  {
                Text(error.message)
                    .foregroundColor(.red)
                    .font(.caption)
                 
            }
        }
        .padding(.bottom, 19)
    }
}

struct EmojiPicker_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            EmojiPicker(name: "itemLogo", emoji: .constant(""))
                .environmentObject(ErrorData())
            
            EmojiPicker(name: "itemLogo", emoji: .constant("🎒"))
                .environmentObject(ErrorData())
        }
    }
}

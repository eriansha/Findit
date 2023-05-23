//
//  EmojiPicker.swift
//  Findit
//
//  Created by Ivan on 22/05/23.
//

import SwiftUI

struct EmojiPicker: View {
    @Binding public var emoji: String
    @Binding public var isPresented: Bool
    
    var emojiSequences = [
        // 0x1F601...0x1F64F,
        0x1F380...0x1F393,
        0x1F50A...0x1F514,
        0x1F516...0x1F52B,
        0x1F4B8...0x1F4EB,
        0x1FA70...0x1FA73,
        0x1F699...0x1F69A,
        0x1F6C1...0x1F6D2
    ]
    
    func pickEmoji(_ selectedEmoji: Int) {
        if (UnicodeScalar(selectedEmoji)?.properties.isEmoji)! {
            if let unicodeScalar = UnicodeScalar(selectedEmoji) {
                let emojiChar = Character(unicodeScalar)
                let emojiString = String(emojiChar)
                emoji = emojiString
            } else {
                print("Cannot parse selected emoji Int16 into Unicode")
            }
        } else {
            emoji = ""
        }
        
        isPresented.toggle()
    }
    
    func getEmojiList() -> [[Int]] {
        var emojis: [[Int]] = []
        
        for seq in emojiSequences {
            for i in seq {
                var temp: [Int] = []
                for j in i...i {
                    temp.append(j)
                }
                
                emojis.append(temp)
            }
        }
        
        return emojis
    }
    
    private let adaptiveColums = [
        GridItem(.adaptive(minimum: 70))
    ]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: adaptiveColums, spacing: 16) {
                ForEach(getEmojiList(), id: \.self) { row in
                    HStack(spacing: 25) {
                        ForEach(row, id: \.self) { emoji in
                            Button(action: {
                                pickEmoji(emoji)
                            }) {
                                if (UnicodeScalar(emoji)?.properties.isEmoji)! {
                                    Text(String(UnicodeScalar(emoji)!))
                                        .font(Theme.FontSize.large)
                                } else {
                                    Text("")
                                }
                            }
                        }
                    }
                }
            }
            .padding(.top)
        }
        .ignoresSafeArea(.all)
    }
}

struct EmojiPicker_Previews: PreviewProvider {
    static var previews: some View {
        EmojiPicker(
            emoji: .constant("🎒"),
            isPresented: .constant(true)
        )
    }
}

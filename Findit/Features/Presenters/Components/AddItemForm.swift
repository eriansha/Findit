//
//  AddItemForm.swift
//  Findit
//
//  Created by Ivan on 22/05/23.
//

import SwiftUI

struct EmojiSheet: View {
    var body: some View {
        EmojiPicker()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .edgesIgnoringSafeArea(.bottom)
    }
}

struct AddItemForm: View {
    @State private var isPresented: Bool = false
    @State private var emoji: String = ""
    @State private var name: String = ""
    @State private var uuid: String = ""
    @State private var major: String = ""
    @State private var minor: String = ""
    
    func addItem() {
        // TODO
    }
    
    
    var body: some View {
        VStack {
            HStack {
                Text("Add Item")
                    .bold()
                    .font(.title2)
                Spacer()
            }
            .padding()
            
            ScrollView {
                ZStack {
                    Circle()
                        .fill(Theme.Colors.gray500)
                        .frame(width: 150, height: 150)
                    
                    Button {
                        isPresented.toggle()
                    } label: {
                        VStack {
                            Image(systemName: "face.dashed")
                                .foregroundColor(.gray)
                                .font(Theme.FontSize.large)
                                .padding(.bottom, 1)
                            Text("Select Emoji")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }.sheet(isPresented: $isPresented) {
                        EmojiSheet()
                            .presentationDetents([.height(400), .medium, .large])
                            .presentationDragIndicator(.automatic)
                            .padding(.top, 32)
                    }
                }
                .padding(.bottom, 19)
                
                InputField(label: "Name", value: $name)
                    .padding(.bottom, 16)
                InputField(label: "UUID", value: $uuid)
                    .padding(.bottom, 16)
                InputField(label: "Major", value: $major)
                    .padding(.bottom, 16)
                InputField(label: "Minor", value: $minor)
                    .padding(.bottom, 19)
                
                Button(action: addItem) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.blue)
                            .frame(width: 374, height: 43)
                        
                        Text("Add Item")
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

struct AddItemForm_Previews: PreviewProvider {
    static var previews: some View {
        AddItemForm()
    }
}

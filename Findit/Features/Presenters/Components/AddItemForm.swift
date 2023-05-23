//
//  AddItemForm.swift
//  Findit
//
//  Created by Ivan on 22/05/23.
//

import SwiftUI

struct EmojiSheet: View {
    @Binding var logo: String
    
    var body: some View {
        EmojiPicker(emoji: $logo)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .edgesIgnoringSafeArea(.bottom)
    }
}

struct AddItemForm: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var isPresented: Bool = false
    @State private var itemLogo: String = ""
    @State private var itemName: String = ""
    @State private var beaconUUIDString: String = ""
    @State private var beaconMajor: String = ""
    @State private var beaconMinor: String = ""
    
    func addItem() {
        let parsedBeaconMajor = Int16(beaconMajor) ?? 0
        let parsedBeaconMinor = Int16(beaconMinor) ?? 0
        
        FinditController().addItem(
            name: itemName,
            logo: itemLogo,
            beaconUUIDString: beaconUUIDString,
            beaconMajor: parsedBeaconMajor,
            beaconMinor: parsedBeaconMinor,
            context: managedObjectContext
        )
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Add Item")
                    .bold()
                    .font(.title2)
                    .padding(.vertical, 16)
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
                        EmojiSheet(logo: $itemLogo)
                            .presentationDetents([.height(400), .medium, .large])
                            .presentationDragIndicator(.automatic)
                            .padding(.top, 32)
                    }
                }
                .padding(.bottom, 19)
                
                InputField(label: "Name", value: $itemName)
                    .padding(.bottom, 16)
                InputField(label: "UUID", value: $beaconUUIDString)
                    .padding(.bottom, 16)
                InputField(label: "Major", value: $beaconMajor)
                    .keyboardType(.numberPad)
                    .padding(.bottom, 16)
                InputField(label: "Minor", value: $beaconMinor)
                    .keyboardType(.numberPad)
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

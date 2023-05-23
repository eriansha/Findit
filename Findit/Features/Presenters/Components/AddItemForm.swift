//
//  AddItemForm.swift
//  Findit
//
//  Created by Ivan on 22/05/23.
//

import SwiftUI

struct AddItemForm: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var errorData: ErrorData
    
    @Binding public var showSheet: Bool
    
    @State private var itemLogo: String = ""
    @State private var itemName: String = ""
    @State private var beaconUUIDString: String = ""
    @State private var beaconMajor: String = ""
    @State private var beaconMinor: String = ""
    
    @State private var errorFields: [ErrorField] = []
    
    func addItem() {
        // reset error field once it has been resubmitted
        errorData.errorFields = ItemViewModel.ValidateItem(
            name: itemName,
            logo: itemLogo,
            beaconUUIDString: beaconUUIDString,
            beaconMajor: beaconMajor,
            beaconMinor: beaconMinor
        )
        
        guard errorData.errorFields.count == 0 else {
            return
        }
        
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
        
        // close the sheet once the item has been added
        showSheet.toggle()
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
                EmojiPicker(
                    name: ItemCreationName.itemLogo.rawValue,
                    emoji: $itemLogo
                )
                
                InputField(
                    name: ItemCreationName.itemName.rawValue,
                    label: "Name",
                    value: $itemName
                ).padding(.bottom, 16)
                InputField(
                    name: ItemCreationName.beaconUUIDString.rawValue,
                    label: "Beacon UUID",
                    value: $beaconUUIDString
                ).padding(.bottom, 16)
                InputField(
                    name: ItemCreationName.beaconMajor.rawValue,
                    label: "Beacon Major",
                    value: $beaconMajor
                ).keyboardType(.numberPad).padding(.bottom, 16)
                InputField(
                    name: ItemCreationName.beaconMinor.rawValue,
                    label: "Beacon Minor",
                    value: $beaconMinor
                ).keyboardType(.numberPad).padding(.bottom, 19)
                
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
        AddItemForm(showSheet: .constant(true))
            .environmentObject(ErrorData())
    }
}

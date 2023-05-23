//
//  InputField.swift
//  Findit
//
//  Created by Ivan on 20/05/23.
//

import SwiftUI

struct InputField: View {
    public var label = "Name"
    @Binding var value: String
    
    @State private var isTextFieldFocused: Bool = false
    
    func resetField() {
        value = ""
    }
    
    var borderColor: Color {
        isTextFieldFocused ? .blue : .gray
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(label)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.bottom, -8)
                    
                    TextField("", text: $value)
                        .onTapGesture {
                            isTextFieldFocused = true
                        }
                }
                
                Spacer()
                
                if !value.isEmpty {
                    Button(action: resetField) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(8)
        }
        .padding(4)
        .cornerRadius(8.0)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(borderColor, lineWidth: 1)
        )
        .padding(.horizontal, 8)
    }
}

struct InputField_Previews: PreviewProvider {
    static var previews: some View {
        InputField(
            label: "Name",
            value: .constant("Bag")
        )
    }
}

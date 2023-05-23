//
//  InputField.swift
//  Findit
//
//  Created by Ivan on 20/05/23.
//

import SwiftUI

struct InputField: View {
    @EnvironmentObject var errorData: ErrorData
    
    public var name: String = ""
    public var label: String = ""
    public var errors: [ErrorField] = []
    @Binding var value: String
    
    @State private var isEditing: Bool = false
    
    func resetField() {
        value = ""
    }
    
    // changing border of input field if it's in edit mode (user type on the field)
    var borderColor: Color {
        isEditing ? .blue : .gray
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(label)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.bottom, -8)
                        
                        TextField("", text: $value, onEditingChanged: { editing in
                            isEditing = editing
                        })
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
            
            if let error = errorData.errorFields.first(where: { $0.key == name })  {
                HStack {
                    Text(error.message)
                        .foregroundColor(.red)
                        .font(.caption)
                    
                    Spacer()
                }
            }
        }
    }
}

struct InputField_Previews: PreviewProvider {
    static var errors: [ErrorField] = [
        .init(key: "fieldName", message: "Please input valid value")
    ]
    
    static var previews: some View {
        InputField(
            name: "fieldName",
            label: "Name",
            errors: errors,
            value: .constant("Bag")
            
        )
        .environmentObject(ErrorData())
    }
}

//
//  ItemViewModel.swift
//  Findit
//
//  Created by Ivan on 23/05/23.
//

import Foundation

enum ItemCreationName: String {
    case itemName
    case itemLogo
    case beaconUUIDString
    case beaconMajor
    case beaconMinor
}

struct ItemViewModel {
    static func ValidateItem(
        name: String,
        logo: String,
        beaconUUIDString: String,
        beaconMajor: String,
        beaconMinor: String
    ) -> [ErrorField] {
        var errors: [ErrorField] = []

        // Item logo
        if name.isEmpty {
            errors.append(.init(
                key: ItemCreationName.itemName.rawValue,
                message: "Please input Item name"
            ))
        }
        
        // Item logo
        if logo.isEmpty {
            errors.append(.init(
                key: ItemCreationName.itemLogo.rawValue,
                message: "Please input Item logo"
            ))
        }
        
        // Beacon UUID validation
        if !beaconUUIDString.isEmpty {
            if UUID(uuidString: beaconUUIDString) == nil {
                errors.append(.init(
                    key: ItemCreationName.beaconUUIDString.rawValue,
                    message: "Invlaid Beacon UUID format"
                ))
            }
        } else {
            errors.append(.init(
                key: ItemCreationName.beaconUUIDString.rawValue,
                message: "Please input Beacon UUID"
            ))
        }
        
        // Beacon Major validation
        if !beaconMajor.isEmpty {
            if Int16(beaconMajor) == nil {
                errors.append(.init(
                    key: ItemCreationName.beaconMajor.rawValue,
                    message: "Invalid value Beacon Major"
                ))
            }
        } else {
            errors.append(.init(
                key: ItemCreationName.beaconMajor.rawValue,
                message: "Please input Beacon Major"
            ))
        }
        
        // Beacon Minor validation
        if !beaconMinor.isEmpty {
            if Int16(beaconMinor) == nil {
                errors.append(.init(
                    key: ItemCreationName.beaconMinor.rawValue,
                    message: "Invalid value Beacon Minor"
                ))
            }
        } else {
            errors.append(.init(
                key: ItemCreationName.beaconMinor.rawValue,
                message: "Please input Beacon Minor"
            ))
        }
        
        return errors
    }
}

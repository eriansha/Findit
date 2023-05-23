//
//  ItemViewModel.swift
//  Findit
//
//  Created by Ivan on 23/05/23.
//

import Foundation
import CoreLocation

enum ItemCreationName: String {
    case itemName
    case itemLogo
    case beaconUUIDString
    case beaconMajor
    case beaconMinor
}

struct ItemViewModel {
    // Humanize proximity
    static func proximityInString(_ distance: CLProximity) -> String {
        switch distance {
        case .near: return "Near"
        case .far: return "Far"
        case .immediate: return "Immediate"
        default: return "Unknown"
        }
    }
    
    /**
        Formating distance
        - rounded to one digit after comma
        - adding Meter unit
     */
    static func formatDistance(_ value: Double) -> String {
        if value > 0 {
            return "\(String(format: "%.1f", value)) m"
        } else {
            return "-"
        }
    }
    
    /** Calculate radar animation time */
    static func calculcateAnimationTime(lastProximity: CLProximity) -> Double {
        switch lastProximity {
        case .unknown:
            return 2
        case .immediate:
            return 0.25
        case .near:
            return 0.5
        case .far:
            return 1
        default:
            return 2
        }
    }
}

/** Validation extension */
extension ItemViewModel {
    /** Validate Item during creation*/
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

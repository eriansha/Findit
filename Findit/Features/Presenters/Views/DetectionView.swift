//
//  DetectionView.swift
//  Findit
//
//  Created by Ivan on 20/05/23.
//

import SwiftUI
import CoreLocation

struct DetectionView: View {
    @StateObject var beaconDetector = BeaconDetector()
    public var item: Item
    
    func distanceInString(_ distance: CLProximity) -> String {
        switch distance {
        case .near: return "Near"
        case .far: return "Far"
        case .immediate: return "Immediate"
        default: return "Unknown"
        }
    }
    
    var body: some View {
        VStack {
            Text("Detect \(item.name)")
            Text(distanceInString(beaconDetector.lastProximity))
            Text("\(beaconDetector.lastDistance) m")
        }
    }
}

struct DetectionView_Previews: PreviewProvider {
    static var dummyItem: Item = Item(
        id: UUID(),
        logo: "🎒",
        name: "Bag",
        beaconUUID: UUID(),
        beaconMajor: 10,
        beaconMinor: 20
    )
    
    static var previews: some View {
        DetectionView(item: dummyItem)
    }
}

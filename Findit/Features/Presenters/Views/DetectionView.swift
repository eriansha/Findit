//
//  DetectionView.swift
//  Findit
//
//  Created by Ivan on 20/05/23.
//

import SwiftUI

struct DetectionView: View {
    public var item: Item
    
    var body: some View {
        Text("Detect \(item.name)")
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

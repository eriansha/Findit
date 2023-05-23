//
//  DetectionView.swift
//  Findit
//
//  Created by Ivan on 20/05/23.
//

import SwiftUI
import CoreLocation

struct DetectionView: View {
    @Environment(\.dismiss) private var dismiss
    
    public var item: Item
    
    @StateObject var beaconDetector: BeaconDetector
    
    init(item: Item) {
        self.item = item

        _beaconDetector = StateObject.init(wrappedValue: BeaconDetector(
            beaconUUID: item.beaconUUID!,
            beaconMajor: UInt16(item.beaconMajor),
            beaconMinor: UInt16(item.beaconMinor)
        ))
    }

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.blue)
                .ignoresSafeArea(.all)
            
            VStack(alignment: .leading) {
                Text("finding")
                    .foregroundColor(.white)
                if let name = item.name {
                    Text(name)
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .bold()
                } else {
                    Text("Item")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .bold()
                }
            }
            .position(x: 60, y: 70)
            
            VStack {
                
                Spacer()
                
                RadarDetector(proximity: beaconDetector.lastProximity).padding(.top, 50)
                
                Text(ItemViewModel.proximityInString(beaconDetector.lastProximity))
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                
                Text(ItemViewModel.formatDistance(beaconDetector.lastDistance))
                    .foregroundColor(.white)
                    .font(.title)
                
                Spacer()
                
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(Theme.FontSize.large)
                        .foregroundColor(.white)
                        .padding(.vertical, 2)
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct DetectionView_Previews: PreviewProvider {
    static var previews: some View {
        DetectionView(item: FinditController.example)
    }
}

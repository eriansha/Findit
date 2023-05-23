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
    
    @StateObject var beaconDetector = BeaconDetector()
    
    func distanceInString(_ distance: CLProximity) -> String {
        switch distance {
        case .near: return "Near"
        case .far: return "Far"
        case .immediate: return "Immediate"
        default: return "Unknown"
        }
    }
    
    func formatDistance(_ value: Double) -> String {
        if value > 0 {
            return "\(String(format: "%.1f", value)) m"
        } else {
            return "-"
        }
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white)
                .ignoresSafeArea(.all)
            
            VStack(alignment: .leading) {
                Text("finding")
                    .foregroundColor(.gray)
                Text(item.name)
                    .font(.largeTitle)
                    .bold()
            }.position(x: 40, y: 40)
            
            VStack {
                
                Spacer()
                
                RadarDetector()
                
                Text(distanceInString(beaconDetector.lastProximity))
                    .font(.largeTitle)
                    .bold()
                
                Text(formatDistance(beaconDetector.lastDistance))
                    .font(.title)
                
                Spacer()
                
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(Theme.FontSize.large)
                        .foregroundColor(.gray)
                        .padding(.vertical, 2)
                }
            }
        }.navigationBarBackButtonHidden(true)
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

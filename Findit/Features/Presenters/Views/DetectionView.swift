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
                
                RadarDetector().padding(.top, 50)
                
                Text(distanceInString(beaconDetector.lastProximity))
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                
                Text(formatDistance(beaconDetector.lastDistance))
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

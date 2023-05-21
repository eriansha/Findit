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
    
    @State var animatePrimaryCircle: Bool = false
    @StateObject var beaconDetector = BeaconDetector()
    
    let primaryCircleSize: Double = 382
    let secondaryCircleSize: Double = 191
    
    func distanceInString(_ distance: CLProximity) -> String {
        switch distance {
        case .near: return "Near"
        case .far: return "Far"
        case .immediate: return "Immediate"
        default: return "Unknown"
        }
    }
    
    func formatDistance(_ value: Double) -> String {
        return String(format: "%.1f", value)
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
                
                ZStack {
                    Circle()
                        .fill(.gray)
                        .frame(
                            width: animatePrimaryCircle
                                ? primaryCircleSize + 10
                                : primaryCircleSize,
                            height: animatePrimaryCircle
                                ? primaryCircleSize + 10
                                : primaryCircleSize
                        )
                        .animation(Animation.linear(duration: 1).repeatForever(autoreverses: true), value: animatePrimaryCircle)
                        .onAppear {
                            animatePrimaryCircle = true
                        }
                    
                    Circle()
                        .fill(.black)
                        .frame(
                            width: secondaryCircleSize,
                            height: secondaryCircleSize
                        )
                }
                
                Text(distanceInString(beaconDetector.lastProximity))
                    .font(.largeTitle)
                    .bold()
                
                Text("\(formatDistance(beaconDetector.lastDistance)) m")
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

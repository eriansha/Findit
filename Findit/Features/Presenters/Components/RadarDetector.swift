//
//  RadarDetector.swift
//  Findit
//
//  Created by Ivan on 23/05/23.
//

import SwiftUI
import CoreLocation

struct RadarDetector: View {
    public var proximity: CLProximity = .unknown
    @State private var timingPrimaryCircle: Double = 1
    @State private var animatedPrimaryCircle: Bool = false
    
    let primaryCircleSize: Double = 270
    let secondaryCircleSize: Double = 180
    
    var body: some View {
        ZStack {
            Circle()
                .fill(.white)
                .opacity(0.4)
                .frame(
                    width: animatedPrimaryCircle
                        ? primaryCircleSize + 90
                        : primaryCircleSize,
                    height: animatedPrimaryCircle
                        ? primaryCircleSize + 90
                        : primaryCircleSize
                )
                .animation(Animation.linear(duration: timingPrimaryCircle).repeatForever(autoreverses: true), value: animatedPrimaryCircle)
                .onAppear {
                    animatedPrimaryCircle = true
                }
            
            Circle()
                .fill(.white)
                .frame(
                    width: secondaryCircleSize,
                    height: secondaryCircleSize
                )
        }.onAppear {
            animatedPrimaryCircle = true
        }
    }
}

struct RadarDetector_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Rectangle()
                .fill(.blue)
                .ignoresSafeArea(.all)
            
            RadarDetector()
        }
    }
}

//
//  RadarDetector.swift
//  Findit
//
//  Created by Ivan on 23/05/23.
//

import SwiftUI

struct RadarDetector: View {
    @State private var animatedPrimaryCircle: Bool = false
    
    let primaryCircleSize: Double = 382
    let secondaryCircleSize: Double = 191
    
    var body: some View {
        ZStack {
            Circle()
                .fill(.gray)
                .frame(
                    width: animatedPrimaryCircle
                        ? primaryCircleSize + 10
                        : primaryCircleSize,
                    height: animatedPrimaryCircle
                        ? primaryCircleSize + 10
                        : primaryCircleSize
                )
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: true), value: animatedPrimaryCircle)
                .onAppear {
                    animatedPrimaryCircle = true
                }
            
            Circle()
                .fill(.black)
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
        RadarDetector()
    }
}

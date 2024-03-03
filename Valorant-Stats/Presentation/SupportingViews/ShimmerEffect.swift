//
//  ShimmerEffect.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 03/03/24.
//

import SwiftUI

struct ShimmerEffect: View {
    
    @State var startPoint: UnitPoint = .init(x: -1, y: 0.5)
    @State var endPoint: UnitPoint = .init(x: 0, y: 0.5)
    
    private var gradientColors = [
        Color.gray.opacity(0.15),
        Color.gray.opacity(0.25),
        Color.gray.opacity(0.5),
        Color.gray.opacity(0.25),
        Color.gray.opacity(0.15)
    ]
    
    var body: some View {
        LinearGradient(colors: gradientColors,
                       startPoint: startPoint,
                       endPoint: endPoint)
            .onAppear {
                withAnimation(.easeInOut(duration: 2.5)
                    .repeatForever(autoreverses: false)) {
                        startPoint = .init(x: 1, y: 0.5)
                        endPoint = .init(x: 2, y: 0.5)
                    }
            }
    }
}

#Preview {
    ShimmerEffect()
}

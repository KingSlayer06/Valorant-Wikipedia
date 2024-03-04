//
//  SplashView.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 04/03/24.
//

import SwiftUI

struct SplashView: View {
    @Binding var splashScreenPresented: Bool
    @State var opacity: Double = 0
    @State var scale = CGSize(width: 0.8, height: 0.8)
    
    var body: some View {
        ZStack {
            KeyVariables.secondaryColor
            
            VStack(spacing: 0) {
                Image("app-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                
                Text("Valorant Wiki")
                    .font(Font.custom(KeyVariables.primaryFont, size: 20))
                    .foregroundStyle(KeyVariables.primaryColor)
                    .padding(.bottom)
                
                Text("Wikipedia for Valorant")
                    .font(Font.custom(KeyVariables.primaryFont, size: 12))
                    .foregroundStyle(.white.opacity(0.5))
            }
        }
        .opacity(opacity)
        .scaleEffect(scale)
        .onAppear {
            withAnimation(.easeIn(duration: 0.15)) {
                scale = CGSize(width: 1, height: 1)
                opacity = 1
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation(.easeIn(duration: 0.35)) {
                    scale = CGSize(width: 50, height: 50)
                    opacity = 0
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.7) {
                withAnimation(.easeIn(duration: 0.2)) {
                    splashScreenPresented = false
                }
            }
        }
    }
}

#Preview {
    SplashView(splashScreenPresented: .constant(true))
}

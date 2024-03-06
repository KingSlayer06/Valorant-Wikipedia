//
//  SplashView.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 04/03/24.
//

import SwiftUI
import FirebaseRemoteConfig

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
                
                Text("Valorant Wikipedia")
                    .font(Font.custom(KeyVariables.primaryFont, size: 20))
                    .foregroundStyle(KeyVariables.primaryColor)
                    .padding(.bottom, 3)
                
                Text("Wikipedia for Valorant")
                    .font(Font.custom(KeyVariables.primaryFont, size: 15))
                    .foregroundStyle(.white.opacity(0.5))
            }
        }
        .opacity(opacity)
        .scaleEffect(scale)
        .onAppear {
            AppAnalytics.shared.ScreenVisit(screen: AppAnalytics.shared.splash)
            
            fetchRemoteConfig()
            
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
    
    func fetchRemoteConfig() {
        let remoteConfig = RemoteConfig.remoteConfig()
        
        let defaults: [String: Bool] = [
            "show_skin_details" : false
        ]
        try? remoteConfig.setDefaults(from: defaults)
        
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        remoteConfig.fetchAndActivate() { (status, error) -> Void in
            if status == .error {
                print("Config not fetched")
                print("Error: \(error?.localizedDescription ?? "No error available.")")
            } else {
                let showSkinDetails = remoteConfig.configValue(forKey: "show_skin_details").boolValue
                KeyVariables.showSkinDetails = showSkinDetails
            }
        }
    }
}

#Preview {
    SplashView(splashScreenPresented: .constant(true))
}

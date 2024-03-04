//
//  Valorant_StatsApp.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 26/02/24.
//

import SwiftUI

@main
struct Valorant_WikiApp: App {
    @State var splashScreenPresented = true
    
    var body: some Scene {
        WindowGroup {
            if splashScreenPresented {
                SplashView(splashScreenPresented: $splashScreenPresented)
            } else {
                HomeView()
                    .environmentObject(HomeViewModel())
            }
        }
    }
}

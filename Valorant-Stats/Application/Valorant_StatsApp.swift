//
//  Valorant_StatsApp.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 26/02/24.
//

import SwiftUI

@main
struct Valorant_WikiApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @State var splashScreenPresented = true
    @StateObject private var homeViewModel = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            if splashScreenPresented {
                SplashView(splashScreenPresented: $splashScreenPresented)
            } else {
                HomeView()
                    .environmentObject(homeViewModel)
            }
        }
    }
}

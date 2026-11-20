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
    @State private var homeViewModel = HomeViewModel()
    @State private var navigationManager = NavigationManager()

    var body: some Scene {
        WindowGroup {
            if splashScreenPresented {
                SplashView(splashScreenPresented: $splashScreenPresented)
            } else {
                HomeView()
                    .environment(homeViewModel)
                    .environment(navigationManager)
            }
        }
    }
}

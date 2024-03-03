//
//  Valorant_StatsApp.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 26/02/24.
//

import SwiftUI

@main
struct Valorant_WikiApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(HomeViewModel())
        }
    }
}

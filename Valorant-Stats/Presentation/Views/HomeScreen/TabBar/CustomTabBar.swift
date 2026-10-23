//
//  CustomTabBar.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 07/03/24.
//

import SwiftUI
import UIKit

struct CustomTabBar: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel

    init() {
        TabBarAppearance.configure()
    }

    var body: some View {
        TabView(selection: $homeViewModel.selectedBottomTab) {
            AgentsView()
                .tabItem { Label(SideMenuOptionsModel.agents.title, systemImage: "person.2.fill") }
                .tag(SideMenuOptionsModel.agents)

            MapsView()
                .tabItem { Label(SideMenuOptionsModel.maps.title, systemImage: "map.fill") }
                .tag(SideMenuOptionsModel.maps)

            WeaponsView()
                .tabItem { Label(SideMenuOptionsModel.weapons.title, systemImage: "scope") }
                .tag(SideMenuOptionsModel.weapons)
        }
        .tabViewStyle(.automatic)
        .tint(KeyVariables.primaryColor)
        .toolbarBackground(KeyVariables.secondaryColor.opacity(0.92), for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
    }
}

private enum TabBarAppearance {
    static func configure() {
        let appearance = UITabBarAppearance()
        let itemAppearance = UITabBarItemAppearance()
        let font = UIFont(name: KeyVariables.primaryFont, size: 8) ?? .systemFont(ofSize: 8, weight: .semibold)
        let primaryColor = UIColor(red: 253 / 255, green: 69 / 255, blue: 86 / 255, alpha: 1)

        itemAppearance.normal.titleTextAttributes = [.font: font, .foregroundColor: UIColor.white]
        itemAppearance.normal.iconColor = UIColor.white
        itemAppearance.selected.titleTextAttributes = [.font: font, .foregroundColor: primaryColor]
        itemAppearance.selected.iconColor = primaryColor

        appearance.stackedLayoutAppearance = itemAppearance
        appearance.inlineLayoutAppearance = itemAppearance
        appearance.compactInlineLayoutAppearance = itemAppearance
        appearance.selectionIndicatorTintColor = primaryColor

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}

#Preview {
    CustomTabBar()
        .environmentObject(HomeViewModel())
}

//
//  ContentView.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 26/02/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @State var showMenu: Bool = false
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                KeyVariables.secondaryColor
                TabView(selection: $homeViewModel.selectedTab) {
                    ForEach(SideMenuOptionsModel.allCases) { tab in
                        switch tab {
                        case .agents:
                            AgentsView()
                                .tag(tab)
                        case .maps:
                            MapsView()
                                .tag(tab)
                        case .weapons:
                            WeaponsView()
                                .tag(tab)
                        case .playerCards:
                            PlayerCardsView()
                                .tag(tab)
                        case .sprays:
                            SpraysView()
                                .tag(tab)
                        case .ranks:
                            RanksView()
                                .tag(tab)
                        }
                    }
                }
                .ignoresSafeArea()
                
                SideMenuView(isShowing: $showMenu)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    withAnimation(.easeInOut(duration: 3)) {
                        Text("\(homeViewModel.selectedTab.title)")
                            .font(Font.custom(KeyVariables.primaryFont, size: 20))
                            .foregroundStyle(.foreground)
                            .opacity(showMenu ? 0 : 1)
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showMenu.toggle()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundStyle(KeyVariables.primaryColor)
                    }
                }
            }
        }
        .onAppear {
            homeViewModel.showShimmer = true
            homeViewModel.getAgents()
            homeViewModel.getWeapons()
            homeViewModel.getMaps()
            homeViewModel.getPlayerCards()
            homeViewModel.getSprays()
            homeViewModel.getRanks()
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}

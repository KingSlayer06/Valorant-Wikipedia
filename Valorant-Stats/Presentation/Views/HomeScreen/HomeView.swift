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
                
                VStack {
                    switch(homeViewModel.selectedTab) {
                        case .agents:
                            AgentsView()
                        case .maps:
                            MapsView()
                        case .weapons:
                            WeaponsView()
                        case .playerCards:
                            PlayerCardsView()
                        case .sprays:
                            SpraysView()
                        case .ranks:
                            RanksView()
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
                
                SideMenuView(isShowing: $showMenu)
            }
            .gesture (
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onEnded { value in
                        if value.translation.width > 0 {
                            AppAnalytics.shared.SideMenuOpened(selectedTab: homeViewModel.selectedTab.title)
                            showMenu.toggle()
                        }
                    }
            )
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
                        AppAnalytics.shared.SideMenuOpened(selectedTab: homeViewModel.selectedTab.title)
                        showMenu.toggle()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundStyle(KeyVariables.primaryColor)
                    }
                }
            }
        }
        .onAppear {
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

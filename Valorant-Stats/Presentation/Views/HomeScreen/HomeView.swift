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
    @GestureState private var menuDragOffset: CGFloat = 0
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                let menuWidth = min(max(proxy.size.width * 0.72, 280), 360)
                let restingOffset = showMenu ? menuWidth : 0
                let menuOffset = min(max(restingOffset + menuDragOffset, 0), menuWidth)

                ZStack(alignment: .leading) {
                    KeyVariables.secondaryColor

                    selectedContent
                        .frame(width: proxy.size.width, height: proxy.size.height)
                        .offset(x: menuOffset)
                        .overlay {
                            if menuOffset > 0 {
                                Color.black
                                    .opacity(0.2 * (menuOffset / menuWidth))
                                    .onTapGesture {
                                        withAnimation {
                                            showMenu = false
                                        }
                                    }
                            }
                        }

                    SideMenuView(isShowing: $showMenu, width: menuWidth)
                        .frame(width: menuWidth, height: proxy.size.height, alignment: .leading)
                        .offset(x: menuOffset - menuWidth)
                }
                .frame(width: proxy.size.width, height: proxy.size.height, alignment: .leading)
                .animation(.easeOut, value: showMenu)
                .gesture(
                    DragGesture()
                        .updating($menuDragOffset) { value, state, _ in
                            state = value.translation.width
                        }
                        .onEnded { value in
                            endMenuDrag(value, menuWidth: menuWidth)
                        }
                )
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    withAnimation(.easeInOut(duration: 3)) {
                        if (homeViewModel.selectedTab == .home) {
                            Text("\(homeViewModel.selectedBottomTab.title)")
                                .font(Font.custom(KeyVariables.primaryFont, size: 20))
                                .foregroundStyle(.foreground)
                                .opacity(showMenu ? 0 : 1)
                        } else {
                            Text("\(homeViewModel.selectedTab.title)")
                                .font(Font.custom(KeyVariables.primaryFont, size: 20))
                                .foregroundStyle(.foreground)
                                .opacity(showMenu ? 0 : 1)
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        AppAnalytics.shared.BergerMenuIconClick(screen: homeViewModel.selectedTab.title)
                        AppAnalytics.shared.SideMenuOpened(selectedTab: homeViewModel.selectedTab.title)
                        showMenu.toggle()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundStyle(KeyVariables.primaryColor)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        AboutView()
                    } label: {
                        Image(systemName: "questionmark.circle")
                            .foregroundStyle(KeyVariables.primaryColor)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        AppAnalytics.shared.QuestionMarkIconClick(screen: homeViewModel.selectedTab.title)
                    })
                    .allowsHitTesting(!showMenu)
                }
            }
        }
        .onAppear {
            homeViewModel.getAgents()
            homeViewModel.getWeapons()
            homeViewModel.getMaps()
            homeViewModel.getBuddies()
            homeViewModel.getPlayerCards()
            homeViewModel.getSprays()
            homeViewModel.getRanks()
            homeViewModel.getBundles()
            homeViewModel.getAgentContracts()
        }
    }

    private func endMenuDrag(_ value: DragGesture.Value, menuWidth: CGFloat) {
        let projectedOffset = (showMenu ? menuWidth : 0) + value.predictedEndTranslation.width

        withAnimation {
            showMenu = projectedOffset > menuWidth / 2
        }
    }
}

extension HomeView {
    @ViewBuilder
    var selectedContent: some View {
        switch homeViewModel.selectedTab {
        case .home:
            tabBar
        case .playerCards:
            PlayerCardsView()
        case .sprays:
            SpraysView()
        case .ranks:
            RanksView()
        case .bundles:
            BundlesView()
        case .contracts:
            AgentContractsView()
        case .patchNotes:
            PatchNotesView()
        default:
            EmptyView()
        }
    }

    var tabBar: some View {
        CustomTabBar()
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}

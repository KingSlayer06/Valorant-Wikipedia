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
    
    @State var offset: CGFloat = 0
    @State var lastStoredOffset: CGFloat = 0
    
    @GestureState var gestureOffset: CGFloat = 0
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        let sideMenuwidth = KeyVariables.sideMenuWidth
        
        NavigationStack {
            ZStack {
                KeyVariables.secondaryColor
                
                HStack(spacing: 0) {
                    SideMenuView(isShowing: $showMenu)
                    
                    VStack(spacing: 0) {
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
                            case .patchNotes:
                                PatchNotesView()
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .overlay {
                        Rectangle()
                            .opacity(Double((offset/sideMenuwidth)/5))
                            .ignoresSafeArea(.container, edges: .vertical)
                            .onTapGesture {
                                withAnimation {
                                    showMenu.toggle()
                                }
                            }
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
                .frame(width: UIScreen.main.bounds.width + sideMenuwidth)
                .offset(x: -sideMenuwidth/2)
                .offset(x: offset > 0 ? offset : 0)
                .gesture(
                    DragGesture()
                        .updating($gestureOffset) { value, out, _ in
                            out = value.translation.width
                        }
                        .onEnded(onEnded(value: ))
                )
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
        }
        .animation(.easeOut, value: offset == 0)
        .onChange(of: showMenu) {
            if showMenu && offset == 0 {
                offset = sideMenuwidth
                lastStoredOffset = offset
            }
            
            if !showMenu && offset == sideMenuwidth {
                offset = 0
                lastStoredOffset = 0
            }
        }
        .onChange(of: gestureOffset) {
            onChange()
        }
    }
    
    func onChange() {
        let sideMenuwidth = KeyVariables.sideMenuWidth
        
        offset = (gestureOffset != 0) ? (gestureOffset + lastStoredOffset < sideMenuwidth ? gestureOffset + lastStoredOffset : offset) : offset
    }
    
    func onEnded(value: DragGesture.Value) {
        let sideMenuwidth = KeyVariables.sideMenuWidth
        let translation = value.translation.width
        
        withAnimation {
            if translation > 0 {
                if translation > (sideMenuwidth/2) {
                    offset = sideMenuwidth
                    showMenu = true
                } else {
                    if offset == sideMenuwidth {
                        return
                    }
                    
                    offset = 0
                    showMenu = false
                }
            } else {
                if -translation > (sideMenuwidth/2) {
                    offset = 0
                    showMenu = false
                } else {
                    if offset == 0 || !showMenu {
                        return
                    }
                    
                    offset = sideMenuwidth
                    showMenu = true
                }
            }
        }
        
        lastStoredOffset = offset
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}

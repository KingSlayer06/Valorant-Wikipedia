//
//  ViewAllBuddiesView.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 07/03/24.
//

import SwiftUI
import Kingfisher

struct ViewAllBuddiesView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    let columns = [GridItem(.flexible(), spacing: 20),
                   GridItem(.flexible(), spacing: 20)]
    
    @State private var searchBuddy = ""
    
    var filteredBuddies: [Buddy] {
        guard !searchBuddy.isEmpty else { return homeViewModel.buddies }
        
        return homeViewModel.buddies.filter { $0.displayName.localizedCaseInsensitiveContains(searchBuddy) }
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack {
                KeyVariables.secondaryColor
                
                VStack {
                    SearchBarView(searchTerm: $searchBuddy, prompt: "Search Gun Buddy")
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(filteredBuddies, id:\.uuid) { buddy in
                            NavigationLink {
                                WeaponBuddyDetailView(buddy: buddy)
                            } label: {
                                BuddyGridView(buddy: buddy)
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                AppAnalytics.shared.ViewAllBuddiesImageClick(buddy: buddy)
                            })
                            .allowsHitTesting(KeyVariables.showBuddyDetails)
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, KeyVariables.bottomSafeAreaInsets)
        }
        .edgesIgnoringSafeArea(.bottom)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Gun Buddies")
                    .font(Font.custom(KeyVariables.primaryFont, size: 20))
                    .foregroundStyle(.foreground)
            }
        }
        .onAppear {
            AppAnalytics.shared.ScreenVisit(screen: AppAnalytics.shared.viewAllBuddiesScreen)
        }
        .onDisappear {
            AppAnalytics.shared.ViewAllBuddiesBackClick()
        }
    }
}

struct BuddyGridView: View {
    let buddy: Buddy
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .stroke(KeyVariables.primaryColor, lineWidth: 2)
            
            VStack {
                KFImage(URL(string: buddy.displayIcon))
                    .placeholder {
                        Image(systemName: "questionmark.app.dashed")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .frame(height: 35)
                    }
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .padding(.top)
                
                Text(buddy.displayName)
                    .font(Font.custom(KeyVariables.primaryFont, size: 15))
                    .foregroundStyle(.foreground)
            }
        }
        .frame(maxHeight: 150)
    }
}

#Preview {
    ViewAllBuddiesView()
        .environmentObject(HomeViewModel())
}

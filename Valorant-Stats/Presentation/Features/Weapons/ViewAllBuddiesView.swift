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
    @State private var selectedBuddy: Buddy?

    var filteredBuddies: [Buddy] {
        guard !searchBuddy.isEmpty else { return homeViewModel.buddies }

        return homeViewModel.buddies.filter { $0.displayName.localizedCaseInsensitiveContains(searchBuddy) }
    }

    var body: some View {
        Group {
            if KeyVariables.showBuddyDetails {
                ListDetailArrangement { usesSplitSelection in
                    buddyList(usesSplitSelection: usesSplitSelection)
                } detail: {
                    if let selectedBuddy {
                        WeaponBuddyDetailView(buddy: selectedBuddy)
                            .id(selectedBuddy.uuid)
                    } else {
                        ListDetailPlaceholder(title: "Select a Buddy", systemImage: "key.fill")
                    }
                }
            } else {
                buddyList(usesSplitSelection: false)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Gun Buddies")
                    .font(Font.custom(KeyVariables.primaryFont, size: 20))
                    .foregroundStyle(.foreground)
            }
        }
    }

    private func buddyList(usesSplitSelection: Bool) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack {
                KeyVariables.secondaryColor
                
                VStack {
                    SearchBarView(searchTerm: $searchBuddy, prompt: "Search Gun Buddy")
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(filteredBuddies, id:\.uuid) { buddy in
                            ListDetailLink(
                                usesSplitSelection: usesSplitSelection,
                                isSelected: selectedBuddy?.uuid == buddy.uuid,
                                destination: .buddyDetails(buddy),
                                onTap: { AppAnalytics.shared.ViewAllBuddiesImageClick(buddy: buddy) },
                                select: { selectedBuddy = buddy }
                            ) {
                                BuddyGridView(buddy: buddy)
                            }
                            .allowsHitTesting(KeyVariables.showBuddyDetails)
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
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
        .environment(NavigationManager())
}

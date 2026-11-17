//
//  WeaponBuddyDetailView.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 07/03/24.
//

import SwiftUI
import Kingfisher

struct WeaponBuddyDetailView: View {
    let buddy: Buddy
    
    var body: some View {
        ZStack {
            KeyVariables.secondaryColor
            
            KFImage(URL(string: buddy.displayIcon))
                .resizable()
                .scaledToFit()
                .frame(height: 200)
        }
        .padding(.horizontal)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(buddy.displayName)
                    .font(Font.custom(KeyVariables.primaryFont, size: 20))
                    .foregroundStyle(.foreground)
            }
        }
        .onAppear {
            AppAnalytics.shared.ScreenVisit(screen: AppAnalytics.shared.weaponSkinDetailsScreen)
        }
        .onDisappear {
            AppAnalytics.shared.WeaponBuddyDetailsBackClick(buddy: buddy)
        }
    }
}

#Preview {
    WeaponBuddyDetailView(buddy: Buddy(uuid: "", displayName: "", displayIcon: ""))
}

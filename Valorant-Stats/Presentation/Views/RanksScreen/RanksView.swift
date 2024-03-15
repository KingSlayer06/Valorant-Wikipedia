//
//  RanksView.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 02/03/24.
//

import SwiftUI
import Kingfisher

struct RanksView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    let columns = [GridItem(.flexible(), spacing: 10),
                   GridItem(.flexible(), spacing: 10),
                   GridItem(.flexible(), spacing: 10)]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack {
                KeyVariables.secondaryColor
                
                LazyVGrid(columns: columns, spacing: 10) {
                    if homeViewModel.showSpraysShimmer {
                        ForEach(0..<24) { _ in
                            ShimmerEffect()
                                .frame(height: 180)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                    } else {
                        ForEach(homeViewModel.tiers, id: \.self) { tier in
                            TierGridView(tier: tier)
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, KeyVariables.bottomSafeAreaInsets)
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            AppAnalytics.shared.ScreenVisit(screen: AppAnalytics.shared.rankScreen)
        }
    }
}

struct TierGridView: View {
    
    let tier: Tier
    
    var body: some View {
        ZStack {
            Color(hex: "#\(tier.color.dropLast(2))")
            
            VStack {
                KFImage(URL(string: tier.largeIcon ?? ""))
                    .placeholder {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .foregroundStyle(KeyVariables.primaryColor)
                            .scaleEffect(3)
                    }
                    .resizable()
                    .scaledToFit()
                
                Text(tier.tierName)
                    .font(Font.custom(KeyVariables.primaryFont, size: 15))
                    .foregroundStyle(.foreground)
            }
            .padding(.vertical)
        }
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}

#Preview {
    RanksView()
}

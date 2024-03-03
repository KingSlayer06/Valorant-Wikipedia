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
        let width = (UIScreen.main.bounds.width - 30)/3
        
        ZStack {
            KeyVariables.secondaryColor
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(homeViewModel.tiers, id: \.self) { tier in
                        TierGridView(tier: tier)
                            .frame(width: width, height: width)
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct TierGridView: View {
    
    let tier: Tier
    
    var body: some View {
        ZStack {
            Color(hex: "#\(tier.color.dropLast(2))")
            
            VStack {
                KFImage(URL(string: tier.largeIcon ?? ""))
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

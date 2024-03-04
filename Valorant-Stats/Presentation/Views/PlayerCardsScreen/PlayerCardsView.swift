//
//  PlayerCardsView.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 27/02/24.
//

import SwiftUI
import Kingfisher

struct PlayerCardsView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    let columns = [GridItem(.flexible(), spacing: 20),
                   GridItem(.flexible(), spacing: 20)]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack {
                KeyVariables.secondaryColor
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(homeViewModel.playerCards, id: \.uuid) { card in
                        NavigationLink {
                            PlayerCardDetailsView(card: card)
                        }label: {
                            PlayerCardGridView(card: card)
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            AppAnalytics.shared.PlayerCardImageClick(card: card)
                        })
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, KeyVariables.bottomSafeAreaInsets)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct PlayerCardGridView: View {
    let card: PlayerCard
    
    var body: some View {
        ZStack {
            KFImage(URL(string: card.largeArt))
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 5))
            
            RoundedRectangle(cornerRadius: 5)
                .stroke(KeyVariables.primaryColor, lineWidth: 2)
        }
    }
}

#Preview {
    PlayerCardsView()
        .environmentObject(HomeViewModel())
}

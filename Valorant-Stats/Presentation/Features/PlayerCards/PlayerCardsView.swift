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
    @State private var selectedCard: PlayerCard?

    let columns = [GridItem(.flexible(), spacing: 20),
                   GridItem(.flexible(), spacing: 20)]

    var body: some View {
        ListDetailArrangement { usesSplitSelection in
            cardList(usesSplitSelection: usesSplitSelection)
        } detail: {
            if let selectedCard {
                PlayerCardDetailsView(card: selectedCard)
                    .id(selectedCard.uuid)
            } else {
                ListDetailPlaceholder(title: "Select a Card", systemImage: "person.text.rectangle")
            }
        }
    }

    private func cardList(usesSplitSelection: Bool) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack {
                KeyVariables.secondaryColor
                
                LazyVGrid(columns: columns, spacing: 20) {
                    if homeViewModel.showPlayerCardsShimmer {
                        ForEach(0..<10) { _ in
                            ShimmerEffect()
                                .frame(height: 400)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                    } else {
                        ForEach(homeViewModel.playerCards, id: \.uuid) { card in
                            ListDetailLink(
                                usesSplitSelection: usesSplitSelection,
                                isSelected: selectedCard?.uuid == card.uuid,
                                onTap: { AppAnalytics.shared.PlayerCardImageClick(card: card) },
                                select: { selectedCard = card }
                            ) {
                                PlayerCardDetailsView(card: card)
                            } label: {
                                PlayerCardGridView(card: card)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .onAppear {
            AppAnalytics.shared.ScreenVisit(screen: AppAnalytics.shared.playerCardScreen)
        }
    }
}

struct PlayerCardGridView: View {
    let card: PlayerCard
    
    var body: some View {
        ZStack {
            KFImage(URL(string: card.largeArt ?? ""))
                .placeholder {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .foregroundStyle(KeyVariables.primaryColor)
                        .scaleEffect(3)
                }
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

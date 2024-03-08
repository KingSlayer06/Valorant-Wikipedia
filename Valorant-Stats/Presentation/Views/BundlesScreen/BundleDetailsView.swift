//
//  BundleDetailsView.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 07/03/24.
//

import SwiftUI
import Kingfisher

struct BundleDetailsView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    let bundle: WeaponBundle
    
    var bundleWeapons: [WeaponSkin] {
        var weapons = [WeaponSkin]()
        homeViewModel.weapons.forEach { weapon in
            if let weapon = weapon.skins.first(where: { $0.displayName.contains(bundle.displayName) }) {
                weapons.append(weapon)
            }
        }
        
        return weapons
    }
    
    var bundleCards: [PlayerCard] {
        var cards = [PlayerCard]()
        homeViewModel.playerCards.forEach { playerCard in
            if playerCard.displayName.contains(bundle.displayName) {
                cards.append(playerCard)
            }
        }
        
        return cards
    }
    
    var bundleSprays: [Spray] {
        var sprays = [Spray]()
        homeViewModel.sprays.forEach { spray in
            if spray.displayName.contains(bundle.displayName) {
                sprays.append(spray)
            }
        }
        
        return sprays
    }
    
    var body: some View {
        ZStack {
            KFImage(URL(string: bundle.verticalPromoImage ?? ""))
                .placeholder {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .foregroundStyle(KeyVariables.primaryColor)
                        .scaleEffect(3)
                }
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(bundleWeapons, id:\.uuid) { weapon in
                            BundleDetailsGridView(image: weapon.displayIcon)
                        }
                        
                        ForEach(bundleCards, id: \.uuid) { card in
                            BundleDetailsGridView(image: card.largeArt)
                        }
                        
                        ForEach(bundleSprays, id: \.uuid) { spray in
                            BundleDetailsGridView(image: spray.fullTransparentIcon)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(bundle.displayName)
                    .font(Font.custom(KeyVariables.primaryFont, size: 20))
                    .foregroundStyle(.foreground)
            }
        }
        .onAppear {
            print("bundleWeapons : \(bundleWeapons.count)")
            print("bundleCards : \(bundleCards.count)")
            print("bundleSprays : \(bundleSprays.count)")
        }
    }
}

struct BundleDetailsGridView: View {
    let image: String?
    
    var body: some View {
        ZStack {
            KFImage(URL(string: image ?? ""))
                .placeholder {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .foregroundStyle(KeyVariables.primaryColor)
                        .scaleEffect(3)
                }
                .resizable()
                .scaledToFit()
                .edgesIgnoringSafeArea(.all)
                .padding()
                .clipShape(RoundedRectangle(cornerRadius: 5))
            
            RoundedRectangle(cornerRadius: 5)
                .stroke(KeyVariables.primaryColor, lineWidth: 2)
        }
        .frame(maxWidth: 100, maxHeight: 100)
    }
}

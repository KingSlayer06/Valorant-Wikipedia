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
    @State var selectedIndex = 0
    
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
    
    var spacerLength: CGFloat {
        return (UIScreen.main.bounds.width - 100)/2
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
                .frame(width: UIScreen.main.bounds.width)
                .clipShape(Rectangle())
                .opacity(0.75)
                .edgesIgnoringSafeArea(.all)
            
            LinearGradient(colors: [.black, .clear, .black], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer(minLength: 100)
                
                if selectedIndex < bundleWeapons.count {
                    NavigationLink {
                        WeaponSkinDetailsView(skin: bundleWeapons[selectedIndex])
                    } label: {
                        BundleDetailsImageView(name: bundleWeapons[selectedIndex].displayName,
                                               image: bundleWeapons[selectedIndex].displayIcon)
                    }
//                    .animation(Animation.smooth, value: selectedIndex)
                } else if selectedIndex < bundleWeapons.count + bundleSprays.count {
                    NavigationLink {
                        PlayerCardDetailsView(card: bundleCards[selectedIndex - bundleWeapons.count])
                    } label: {
                        BundleDetailsImageView(name: bundleCards[selectedIndex - bundleWeapons.count].displayName,
                                               image: bundleCards[selectedIndex - bundleWeapons.count].largeArt)
                    }
//                    .animation(Animation.smooth, value: selectedIndex)
                } else {
                    BundleDetailsImageView(name: bundleSprays[selectedIndex - bundleWeapons.count - bundleCards.count].displayName,
                                           image: bundleSprays[selectedIndex - bundleWeapons.count - bundleCards.count].fullTransparentIcon)
//                    .animation(Animation.smooth, value: selectedIndex)
                }
                
                Spacer(minLength: 100)
                
                ScrollViewReader { scrollView in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            
                            Spacer(minLength: spacerLength)
                            
                            ForEach(bundleWeapons.indices, id:\.self) { index in
                                BundleDetailsGridView(image: bundleWeapons[index].displayIcon) {
                                    selectedIndex = index
                                }
                                .id(index)
                            }
                            
                            ForEach(bundleCards.indices, id: \.self) { index in
                                BundleDetailsGridView(image: bundleCards[index].largeArt) {
                                    selectedIndex = index + bundleWeapons.count
                                }
                                .id(index + bundleWeapons.count)
                            }
                            
                            ForEach(bundleSprays.indices, id: \.self) { index in
                                BundleDetailsGridView(image: bundleSprays[index].fullTransparentIcon) {
                                    selectedIndex = index + bundleWeapons.count + bundleSprays.count
                                }
                                .id(index + bundleWeapons.count + bundleSprays.count)
                            }
                            
                            Spacer(minLength: spacerLength)
                        }
                        .padding(.horizontal)
                    }
                    .onChange(of: selectedIndex) { oldValue, newValue in
                        withAnimation(.smooth) {
                            scrollView.scrollTo(newValue, anchor: .center)
                        }
                    }
                }
            }
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
    let onClick: () -> Void
    
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
        .contentShape(RoundedRectangle(cornerRadius: 5))
        .frame(width: 100, height: 100)
        .onTapGesture {
            onClick()
        }
    }
}

struct BundleDetailsImageView: View {
    let name: String
    let image: String?
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.75)
                .blur(radius: 0.75)
            
            VStack(spacing: 10) {
                Text(name)
                    .font(Font.custom(KeyVariables.primaryFont, size: 20))
                    .foregroundStyle(.foreground)
                    .multilineTextAlignment(.center)
                
                Spacer(minLength: 0)
                
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
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                
                Spacer(minLength: 0)
            }
            .padding()
            
            RoundedRectangle(cornerRadius: 5)
                .stroke(KeyVariables.primaryColor, lineWidth: 2)
            
        }
        .padding(.horizontal)
    }
}

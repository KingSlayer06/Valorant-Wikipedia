//
//  ViewAllSkinsView.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 04/03/24.
//

import SwiftUI
import Kingfisher

struct ViewAllSkinsView: View {
    let skins: [WeaponSkin]
    let weaponName: String
    
    let columns = [GridItem(.flexible(), spacing: 20),
                   GridItem(.flexible(), spacing: 20)]
    
    @State private var searchSkin = ""
    
    var filteredSkins: [WeaponSkin] {
        guard !searchSkin.isEmpty else { return skins }
        
        return skins.filter { $0.displayName.localizedCaseInsensitiveContains(searchSkin) }
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack {
                KeyVariables.secondaryColor
                
                VStack {
                    SearchBarView(searchTerm: $searchSkin, prompt: "Search Skin")
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(filteredSkins, id:\.uuid) { skin in
                            NavigationLink {
                                WeaponSkinDetailsView(skin: skin)
                            } label: {
                                SkinGridView(skin: skin)
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                AppAnalytics.shared.ViewAllSkinsImageClick(weaponName: weaponName, skin: skin)
                            })
                            .allowsHitTesting(KeyVariables.showSkinDetails)
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
                Text("\(weaponName) Skins")
                    .font(Font.custom(KeyVariables.primaryFont, size: 20))
                    .foregroundStyle(.foreground)
            }
        }
        .onAppear {
            AppAnalytics.shared.ScreenVisit(screen: AppAnalytics.shared.viewAllSkinsScreen)
        }
        .onDisappear {
            AppAnalytics.shared.ViewAllSkinsBackClick(weaponName: weaponName)
        }
    }
}

struct SkinGridView: View {
    let skin: WeaponSkin
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .stroke(KeyVariables.primaryColor, lineWidth: 2)
            
            VStack {
                KFImage(URL(string: skin.displayIcon ?? ""))
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
                
                Text(skin.displayName)
                    .font(Font.custom(KeyVariables.primaryFont, size: 15))
                    .foregroundStyle(.foreground)
            }
        }
        .frame(maxHeight: 150)
    }
}

#Preview {
    ViewAllSkinsView(skins: [], weaponName: "")
}

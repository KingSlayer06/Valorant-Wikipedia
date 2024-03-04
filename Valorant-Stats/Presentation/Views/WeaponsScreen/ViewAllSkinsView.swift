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
    
    let columns = [GridItem(.flexible(), spacing: 20),
                   GridItem(.flexible(), spacing: 20)]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack {
                KeyVariables.secondaryColor
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(skins, id:\.uuid) { skin in
                        NavigationLink {
                            WeaponSkinDetailsView(skin: skin)
                        } label: {
                            SkinGridView(skin: skin)
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, KeyVariables.bottomSafeAreaInsets)
        }
        .edgesIgnoringSafeArea(.bottom)
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
    ViewAllSkinsView(skins: [])
}

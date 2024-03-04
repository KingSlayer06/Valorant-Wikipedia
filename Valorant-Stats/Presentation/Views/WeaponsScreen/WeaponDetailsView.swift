//
//  WeaponDetailsView.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 26/02/24.
//

import SwiftUI
import Kingfisher

struct WeaponDetailsView: View {
    let weapon: Weapon
    let width = (UIScreen.main.bounds.width)/4
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                ZStack {
                    KeyVariables.secondaryColor
                    
                    VStack {
                        KFImage(URL(string: weapon.displayIcon))
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                        
                        weaponName
                        weaponCreds
                        weaponMagzine
                        fireRate
                        damage
                        weaponSkins
                    }
                }
                .padding(.horizontal)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Weapon Details")
                    .font(Font.custom(KeyVariables.primaryFont, size: 20))
                    .foregroundStyle(.foreground)
            }
        }
        .onDisappear {
            AppAnalytics.shared.WeaponDetailsBackClick(weapon: weapon)
        }
    }
}

extension WeaponDetailsView {
    
    var weaponName: some View {
        StatsCellView(label: "Name", icon: nil, value: weapon.displayName)
    }
    
    var weaponCreds: some View {
        StatsCellView(label: "Creds", icon: nil, value: String(describing: weapon.shopData?.cost ?? 0))
    }
    
    var weaponMagzine: some View {
        StatsCellView(label: "Magzine", icon: nil, value: String(describing: weapon.weaponStats?.magazineSize ?? 0))
    }
    
    var fireRate: some View {
        StatsCellView(label: "Fire Rate", icon: nil, value: "\(String(describing: weapon.weaponStats?.fireRate ?? 0)) Rounds/Sec")
    }
    
    var damage: some View {
        VStack {
            Text("Damage")
                .font(Font.custom(KeyVariables.primaryFont, size: 20))
                .foregroundStyle(KeyVariables.primaryColor)
            
            HStack {
                Text("Range")
                    .font(Font.custom(KeyVariables.primaryFont, size: 20))
                    .foregroundStyle(KeyVariables.primaryColor)
                    .frame(maxWidth: width)
                
                Text("Body")
                    .font(Font.custom(KeyVariables.primaryFont, size: 20))
                    .foregroundStyle(KeyVariables.primaryColor)
                    .frame(maxWidth: width)
                
                Text("Head")
                    .font(Font.custom(KeyVariables.primaryFont, size: 20))
                    .foregroundStyle(KeyVariables.primaryColor)
                    .frame(maxWidth: width)
                
                Text("Leg")
                    .font(Font.custom(KeyVariables.primaryFont, size: 20))
                    .foregroundStyle(KeyVariables.primaryColor)
                    .frame(maxWidth: width)
            }
            
            ForEach(weapon.weaponStats!.damageRanges, id: \.self) { damage in
                HStack {
                    Text("\(damage.rangeStartMeters)-\(damage.rangeEndMeters)")
                        .font(Font.custom(KeyVariables.primaryFont, size: 20))
                        .foregroundStyle(.foreground)
                        .frame(maxWidth: width)
                    
                    Text("\(String(format: "%.1f", damage.bodyDamage))")
                        .font(Font.custom(KeyVariables.primaryFont, size: 20))
                        .foregroundStyle(.foreground)
                        .frame(maxWidth: width)
                    
                    Text("\(String(format: "%.1f", damage.headDamage))")
                        .font(Font.custom(KeyVariables.primaryFont, size: 20))
                        .foregroundStyle(.foreground)
                        .frame(maxWidth: width)
                    
                    Text("\(String(format: "%.1f", damage.legDamage))")
                        .font(Font.custom(KeyVariables.primaryFont, size: 20))
                        .foregroundStyle(.foreground)
                        .frame(maxWidth: width)
                }
            }
            
            Rectangle()
                .foregroundStyle(.foreground)
                .frame(height: 2)
        }
    }
    
    var weaponSkins: some View {
        VStack {
            Text("Skins")
                .font(Font.custom(KeyVariables.primaryFont, size: 20))
                .foregroundStyle(KeyVariables.primaryColor)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(weapon.skins, id: \.uuid) { skin in
                        NavigationLink {
                            WeaponSkinDetailsView(skin: skin)
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(KeyVariables.primaryColor, lineWidth: 2)
                                
                                VStack {
                                    KFImage(URL(string: skin.displayIcon ?? ""))
                                        .resizable()
                                        .scaledToFit()
                                    
                                    Text(skin.displayName)
                                        .font(Font.custom(KeyVariables.primaryFont, size: 15))
                                        .foregroundStyle(.foreground)
                                }
                            }
                            .frame(width: 175, height: 150)
                            .padding(.trailing)
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            AppAnalytics.shared.WeaponDetailsSkinClick(skin: skin)
                        })
                    }
                }
            }
        }
    }
}

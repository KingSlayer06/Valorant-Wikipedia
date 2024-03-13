//
//  WeaponDetailsView.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 26/02/24.
//

import SwiftUI
import Kingfisher

struct WeaponDetailsView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    let weapon: Weapon
    let width = (UIScreen.main.bounds.width)/4
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                ZStack {
                    KeyVariables.secondaryColor
                    
                    VStack {
                        KFImage(URL(string: weapon.displayIcon))
                            .placeholder {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .foregroundStyle(KeyVariables.primaryColor)
                                    .scaleEffect(5)
                            }
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: 200)
                        
                        weaponName
                        weaponCreds
                        
                        if weapon.displayName != "Melee" {
                            weaponMagzine
                            fireRate
                            damage
                        }
                            
                        weaponSkins
                        
                        if weapon.displayName != "Melee" {
                            buddies
                        }
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
        .onAppear {
            AppAnalytics.shared.ScreenVisit(screen: AppAnalytics.shared.weaponDetailsScreen)
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
        VStack(spacing: 3) {
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
            
            if let damageRanges = weapon.weaponStats?.damageRanges {
                ForEach(damageRanges, id: \.self) { damage in
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
            }
            
            Rectangle()
                .foregroundStyle(.foreground)
                .frame(height: 2)
        }
    }
    
    var weaponSkins: some View {
        VStack {
            HStack {
                Text("Skins")
                    .font(Font.custom(KeyVariables.primaryFont, size: 20))
                    .foregroundStyle(KeyVariables.primaryColor)
                
                Spacer()
                
                NavigationLink {
                    ViewAllSkinsView(skins: weapon.skins, weaponName: weapon.displayName)
                } label: {
                    Text("View All")
                        .font(Font.custom(KeyVariables.primaryFont, size: 20))
                        .accentColor(.white)
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(weapon.skins.prefix(10), id: \.uuid) { skin in
                        NavigationLink {
                            WeaponSkinDetailsView(skin: skin)
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(KeyVariables.primaryColor, lineWidth: 2)
                                
                                VStack {
                                    KFImage(URL(string: skin.displayIcon ?? ""))
                                        .placeholder {
                                            ProgressView()
                                                .progressViewStyle(CircularProgressViewStyle())
                                                .foregroundStyle(KeyVariables.primaryColor)
                                                .scaleEffect(3)
                                        }
                                        .resizable()
                                        .scaledToFit()
                                    
                                    Text(skin.displayName)
                                        .font(Font.custom(KeyVariables.primaryFont, size: 15))
                                        .foregroundStyle(.foreground)
                                }
                            }
                            .frame(width: 175, height: 175)
                            .padding(.trailing)
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            AppAnalytics.shared.WeaponDetailsSkinClick(skin: skin)
                        })
                    }
                }
            }
            
            Rectangle()
                .foregroundStyle(.foreground)
                .frame(height: 2)
                .padding(.top, 3)
        }
    }
    
    var buddies: some View {
        VStack {
            HStack {
                Text("Buddies")
                    .font(Font.custom(KeyVariables.primaryFont, size: 20))
                    .foregroundStyle(KeyVariables.primaryColor)
                
                Spacer()
                
                NavigationLink {
                    ViewAllBuddiesView()
                } label: {
                    Text("View All")
                        .font(Font.custom(KeyVariables.primaryFont, size: 20))
                        .accentColor(.white)
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(homeViewModel.buddies.prefix(10), id: \.uuid) { buddy in
                        NavigationLink {
                            WeaponBuddyDetailView(buddy: buddy)
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(KeyVariables.primaryColor, lineWidth: 2)
                                
                                VStack {
                                    KFImage(URL(string: buddy.displayIcon))
                                        .placeholder {
                                            ProgressView()
                                                .progressViewStyle(CircularProgressViewStyle())
                                                .foregroundStyle(KeyVariables.primaryColor)
                                                .scaleEffect(3)
                                        }
                                        .resizable()
                                        .scaledToFit()
                                        .padding(.top)
                                    
                                    Text(buddy.displayName)
                                        .font(Font.custom(KeyVariables.primaryFont, size: 15))
                                        .foregroundStyle(.foreground)
                                }
                            }
                            .frame(width: 175, height: 175)
                            .padding(.trailing)
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            AppAnalytics.shared.WeaponDetailsBuddyClick(buddy: buddy)
                        })
                        .allowsHitTesting(KeyVariables.showBuddyDetails)
                    }
                }
            }
        }
    }
}

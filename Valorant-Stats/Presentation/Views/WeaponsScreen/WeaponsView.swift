//
//  WeaponsView.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 26/02/24.
//

import SwiftUI
import Kingfisher

struct WeaponsView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @State var selectedWeapon: String?
    
    var weaponCatagories: [String] {
        var catagories = [String]()
        
        homeViewModel.weapons.forEach { weapon in
            if (!catagories.contains(where: { $0 == weapon.shopData?.categoryText })) {
                if let catagory = weapon.shopData?.categoryText {
                    catagories.append(catagory)
                }
            }
        }
        
        return catagories
    }
    
    var filteredWeapons: [Weapon] {
        guard let selectedWeapon = selectedWeapon else { return homeViewModel.weapons }
        
        if selectedWeapon.contains("Melee") {
            return homeViewModel.weapons.filter { $0.displayName == "Melee" }
        }
        
        return homeViewModel.weapons.filter { $0.shopData?.categoryText == selectedWeapon }
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack {
                KeyVariables.secondaryColor
                
                VStack(spacing: 20) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            if homeViewModel.showWeaponsShimmer {
                                ForEach(0..<5) { _ in
                                    ShimmerEffect()
                                        .frame(width: 80, height: 40)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                }
                            } else {
                                allWeaponsCatagory
                                selectedWeaponCatagory
                                meleeWeaponCatagory
                            }
                            
                            Spacer()
                        }
                    }
                    
                    if homeViewModel.showWeaponsShimmer {
                        ForEach(0..<10) { _ in
                            ShimmerEffect()
                                .frame(height: 180)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                    } else {
                        ForEach(filteredWeapons, id: \.uuid) { weapon in
                            NavigationLink {
                                WeaponDetailsView(weapon: weapon)
                            } label: {
                                WeaponGridView(weapon: weapon)
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                AppAnalytics.shared.WeaponImageClick(weapon: weapon)
                            })
                        }
                    }
                }
                .padding(.top)
            }
            .padding(.horizontal)
            .padding(.bottom, 62)
            .padding(.bottom, KeyVariables.bottomSafeAreaInsets)
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            AppAnalytics.shared.ScreenVisit(screen: AppAnalytics.shared.weaponScreen)
        }
    }
    
    func isSelected(_ catagory: String?) -> Bool {
        guard let selectedWeapon = selectedWeapon else { return false }
        
        return selectedWeapon == catagory
    }
}

struct WeaponGridView: View {
    let weapon: Weapon
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .stroke(KeyVariables.primaryColor, lineWidth: 2)
            
            VStack {
                Text(weapon.displayName)
                    .font(Font.custom(KeyVariables.primaryFont, size: 20))
                    .padding(.vertical)
                    .foregroundStyle(.foreground)
                
                KFImage(URL(string: weapon.displayIcon))
                    .placeholder {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .foregroundStyle(KeyVariables.primaryColor)
                            .scaleEffect(3)
                    }
                    .resizable()
                    .scaledToFit()
                    .padding()
            }
        }
        .frame(height: 180)
    }
}

extension WeaponsView {
    
    var allWeaponsCatagory: some View {
        Text("All")
            .font(Font.custom(KeyVariables.primaryFont, size: 15))
            .foregroundStyle(selectedWeapon == nil ? .white : .black)
            .padding(.horizontal)
            .padding(.vertical, 5)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(selectedWeapon == nil ? KeyVariables.primaryColor : Color.white)
            }
            .onTapGesture {
                selectedWeapon = nil
                AppAnalytics.shared.WeaponTypeClick(weapon: selectedWeapon)
            }
    }
    
    var meleeWeaponCatagory: some View {
        Text("Melee")
            .font(Font.custom(KeyVariables.primaryFont, size: 15))
            .foregroundStyle(selectedWeapon == "Melee" ? .white : .black)
            .padding(.horizontal)
            .padding(.vertical, 5)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(selectedWeapon == "Melee" ? KeyVariables.primaryColor : Color.white)
            }
            .onTapGesture {
                selectedWeapon = "Melee"
                AppAnalytics.shared.WeaponTypeClick(weapon: selectedWeapon)
            }
    }
    
    var selectedWeaponCatagory: some View {
        ForEach(weaponCatagories, id: \.self) { weapon in
            Text(weapon)
                .font(Font.custom(KeyVariables.primaryFont, size: 15))
                .foregroundStyle(isSelected(weapon) ? .white : .black)
                .padding(.horizontal)
                .padding(.vertical, 5)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(isSelected(weapon) ? KeyVariables.primaryColor : Color.white)
                }
                .onTapGesture {
                    selectedWeapon = weapon
                    AppAnalytics.shared.WeaponTypeClick(weapon: selectedWeapon)
                }
        }
    }
}

#Preview {
    WeaponsView()
        .environmentObject(HomeViewModel())
}

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
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack {
                KeyVariables.secondaryColor
                
                VStack(spacing: 20) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            allWeaponsCatagory
                            selectedWeaponCatagory
                            Spacer()
                        }
                    }
                    
                    ForEach(homeViewModel.filteredWeapons, id: \.uuid) { weapon in
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
            .padding(.horizontal)
            .padding(.bottom, KeyVariables.bottomSafeAreaInsets)
        }
        .edgesIgnoringSafeArea(.bottom)
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
                    .resizable()
                    .scaledToFit()
                    .padding(.vertical)
            }
        }
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
                homeViewModel.getFilteredWeapons(catagory: selectedWeapon)
            }
    }
    
    var selectedWeaponCatagory: some View {
        ForEach(homeViewModel.weaponCatagories, id: \.self) { weapon in
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
                    homeViewModel.getFilteredWeapons(catagory: selectedWeapon)
                }
        }
    }
}

#Preview {
    WeaponsView()
        .environmentObject(HomeViewModel())
}

//
//  SideMenuView.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 26/02/24.
//

import SwiftUI

struct SideMenuView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    @Binding var isShowing: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            headerView
                .padding(.horizontal)
            
            VStack {
                ForEach(menuOptions) { option in
                    SideMenuRowView(selectedOption: $homeViewModel.selectedTab, option: option) {
                        homeViewModel.selectedTab = option
                        AppAnalytics.shared.SideMenuRowCick(selectedTab: homeViewModel.selectedTab.title)
                        isShowing.toggle()
                    }
                }
                
                Rectangle()
                    .fill(.white.opacity(0.5))
                    .frame(height: 1.5)
                    .padding(.vertical, 2)
                
                SideMenuRowView(selectedOption: $homeViewModel.selectedTab, option: .patchNotes) {
                    openUrl(url: "https://playvalorant.com/en-us/news/tags/patch-notes/")
                    AppAnalytics.shared.SideMenuRowCick(selectedTab: "Patch Notes")
                    isShowing.toggle()
                }
            }
            
            Spacer()
            
            footerView
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(width: KeyVariables.sideMenuWidth)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func openUrl(url: String) {
        if let url = URL(string: url) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
}

extension SideMenuView {
    
    var headerView: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(KeyVariables.primaryColor)
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Image("app-icon")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.white)
                    .frame(width: 48, height: 48)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.vertical)
            }
            
            VStack(alignment: .leading) {
                Text("Valorant Wikipedia")
                    .font(Font.custom(KeyVariables.primaryFont, size: 15))
                
                Text("Wikipedia for Valorant")
                    .font(Font.custom(KeyVariables.primaryFont, size: 12))
                    .opacity(0.5)
            }
        }
    }
    
    var footerView: some View {
        VStack {
            Text(KeyVariables.appVersion)
                .font(Font.custom(KeyVariables.primaryFont, size: 12))
                .opacity(0.5)
            
            Text("© KingSlayer06")
                .font(Font.custom(KeyVariables.primaryFont, size: 12))
                .opacity(0.5)
        }
        .padding(.bottom)
    }
}

#Preview {
    SideMenuView(isShowing: .constant(true))
        .environmentObject(HomeViewModel())
}

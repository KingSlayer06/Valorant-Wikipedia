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
        let width = UIScreen.main.bounds.width/1.45
        
        ZStack {
            if isShowing {
                Rectangle()
                    .opacity(0.2)
                    .ignoresSafeArea()
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                if value.translation.width < 0 {
                                    AppAnalytics.shared.SideMenuClosed(selectedTab: homeViewModel.selectedTab.title)
                                    isShowing.toggle()
                                }
                            }
                    )
                    .onTapGesture {
                        AppAnalytics.shared.SideMenuClosed(selectedTab: homeViewModel.selectedTab.title)
                        isShowing.toggle()
                    }
                
                HStack {
                    VStack(alignment: .leading, spacing: 32) {
                        headerView
                        
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
                    .padding()
                    .frame(width: width, alignment: .leading)
                    .background(KeyVariables.secondaryColor)
                    
                    Spacer()
                }
                .transition(.move(edge: .leading))
            }
        }
        .animation(.easeInOut, value: isShowing)
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

//
//  CustomTabBar.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 07/03/24.
//

//import SwiftUI
//
//struct CustomTabBar: View {
//    @EnvironmentObject var homeViewModel: HomeViewModel
//    
//    var body: some View {
//        VStack {
//            HStack {
//                ForEach(tabOptions, id: \.id) { tab in
//                    Spacer()
//                    
//                    VStack(spacing: 10) {
//                        Image(tab.image)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 25, height: 25)
//                            .foregroundStyle(homeViewModel.selectedTab == tab ? KeyVariables.primaryColor : .white)
//                    }
//                    .onTapGesture {
//                        homeViewModel.selectedTab = tab
//                    }
//                    
//                    Spacer()
//                }
//            }
//            .padding(.bottom, 15)
//            .frame(height: 108)
//            .background(KeyVariables.secondaryColor)
//        }
//    }
//}
//
//#Preview {
//    CustomTabBar()
//        .environmentObject(HomeViewModel())
//}
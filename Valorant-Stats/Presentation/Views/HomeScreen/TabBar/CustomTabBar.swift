//
//  CustomTabBar.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 07/03/24.
//

import SwiftUI

struct CustomTabBar: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        VStack {
            HStack {
                ForEach(tabOptions, id: \.id) { tab in
                    
                    VStack(spacing: 10) {
                        Text(tab.title)
                            .font(Font.custom(KeyVariables.primaryFont, size: 15))
                            .frame(width: 100, height: 30)
                            .foregroundStyle(.white)
                            .background {
                                if homeViewModel.selectedBottomTab == tab {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(KeyVariables.primaryColor)
                                        .frame(width: 100, height: 30)
                                }
                            }
                    }
                    .animation(.snappy, value: homeViewModel.selectedBottomTab == tab)
                    .onTapGesture {
                        homeViewModel.selectedBottomTab = tab
                    }
                }
            }
            .padding(.bottom, 15)
            .frame(height: 108)
            .frame(maxWidth: .infinity)
            .background {
                KeyVariables.secondaryColor
                    .opacity(0.75)
                    .blur(radius: 0.75)
            }
            .clipShape(UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topLeading: 20, bottomLeading: 0, bottomTrailing: 0, topTrailing: 20)))
        }
    }
}

#Preview {
    CustomTabBar()
        .environmentObject(HomeViewModel())
}

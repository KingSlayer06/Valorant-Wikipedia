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
                                    isShowing.toggle()
                                }
                            }
                    )
                    .onTapGesture {
                        isShowing.toggle()
                    }
                
                HStack {
                    VStack(alignment: .leading, spacing: 32) {
                        headerView
                        
                        VStack {
                            ForEach(SideMenuOptionsModel.allCases) { option in
                                SideMenuRowView(selectedOption: $homeViewModel.selectedTab, option: option) {
                                    homeViewModel.selectedTab = option
                                    isShowing.toggle()
                                }
                            }
                        }
                        
                        Spacer()
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
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Valorant Wiki")
                    .font(.subheadline.bold())
                
                Text("Wikipedia for Valorant")
                    .font(.footnote)
                    .opacity(0.5)
            }
        }
    }
}

#Preview {
    SideMenuView(isShowing: .constant(true))
        .environmentObject(HomeViewModel())
}

//
//  MapsView.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 26/02/24.
//

import SwiftUI
import Kingfisher

struct MapsView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack {
                KeyVariables.secondaryColor
                
                VStack(spacing: 20) {
                    ForEach(homeViewModel.maps, id: \.uuid) { map in
                        NavigationLink {
                            MapDetailsView(map: map)
                        } label: {
                            MapGridView(map: map)
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            AppAnalytics.shared.MapImageClick(map: map)
                        })
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, KeyVariables.bottomSafeAreaInsets)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct MapGridView: View {
    let map: GameMap
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .stroke(KeyVariables.primaryColor, lineWidth: 2)
            
            KFImage(URL(string: map.listViewIcon ?? ""))
                .resizable()
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 5))
            
            LinearGradient(colors: [.black.opacity(0.8), .clear], startPoint: .leading, endPoint: .trailing)
                .clipShape(RoundedRectangle(cornerRadius: 5))
            
            Text(map.displayName)
                .font(Font.custom(KeyVariables.primaryFont, size: 20))
                .padding(.vertical)
                .foregroundStyle(.foreground)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 50)
        }
    }
}

#Preview {
    MapsView()
}

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
    @State private var selectedMap: GameMap?

    var body: some View {
        ListDetailArrangement { usesSplitSelection in
            mapList(usesSplitSelection: usesSplitSelection)
        } detail: {
            mapDetail
        }
    }

    private func mapList(usesSplitSelection: Bool) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack {
                KeyVariables.secondaryColor
                
                VStack(spacing: 20) {
                    if homeViewModel.showMapsShimmer {
                        ForEach(0..<10) { _ in
                            ShimmerEffect()
                                .frame(height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                    }
                    else {
                        ForEach(homeViewModel.maps, id: \.uuid) { map in
                            mapCell(map, usesSplitSelection: usesSplitSelection)
                        }
                    }
                }
                .padding(.top)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .onAppear {
            AppAnalytics.shared.ScreenVisit(screen: AppAnalytics.shared.mapScreen)
        }
    }

    private func mapCell(_ map: GameMap, usesSplitSelection: Bool) -> some View {
        ListDetailLink(
            usesSplitSelection: usesSplitSelection,
            isSelected: selectedMap?.uuid == map.uuid,
            destination: .mapDetails(map),
            onTap: { AppAnalytics.shared.MapImageClick(map: map) },
            select: { selectedMap = map }
        ) {
            MapGridView(map: map)
        }
    }

    @ViewBuilder
    private var mapDetail: some View {
        if let selectedMap {
            MapDetailsView(map: selectedMap)
                .id(selectedMap.uuid)
        } else {
            ListDetailPlaceholder(title: "Select a Map", systemImage: "map")
        }
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
        .environment(NavigationManager())
}

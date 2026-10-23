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
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @State private var selectedMap: GameMap?
    
    var body: some View {
        if #available(iOS 27.1, *), horizontalSizeClass == .regular {
            ArrangementView {
                mapList(usesSplitSelection: true)
            } secondary: {
                mapDetail
            }
            .arrangementViewStyle(.split.axes(.horizontal))
        } else {
            mapList(usesSplitSelection: false)
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

    @ViewBuilder
    private func mapCell(_ map: GameMap, usesSplitSelection: Bool) -> some View {
        if usesSplitSelection {
            Button {
                selectedMap = map
                AppAnalytics.shared.MapImageClick(map: map)
            } label: {
                MapGridView(map: map)
            }
            .buttonStyle(.plain)
        } else {
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

    @ViewBuilder
    private var mapDetail: some View {
        if let selectedMap {
            MapDetailsView(map: selectedMap)
        } else {
            VStack(spacing: 12) {
                Image(systemName: "map")
                    .font(.largeTitle)
                    .foregroundStyle(KeyVariables.primaryColor)
                Text("Select a Map")
                    .font(Font.custom(KeyVariables.primaryFont, size: 20))
                    .foregroundStyle(.foreground)
                Text("Choose an item to view its details.")
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(KeyVariables.secondaryColor)
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
}

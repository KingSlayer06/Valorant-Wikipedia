//
//  MapDetailsView.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 27/02/24.
//

import SwiftUI
import Kingfisher

struct MapDetailsView: View {
    let map: GameMap
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack {
                KeyVariables.secondaryColor
                
                VStack {
                    KFImage(URL(string: map.displayIcon ?? ""))
                        .placeholder {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .foregroundStyle(KeyVariables.primaryColor)
                                .scaleEffect(5)
                        }
                        .resizable()
                        .scaledToFit()
                        .frame(height: 350)
                    
                    mapName
                    mapCoordinates
                    mapDescription
                }
            }
            .padding(.horizontal)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Map Details")
                    .font(Font.custom(KeyVariables.primaryFont, size: 20))
                    .foregroundStyle(.foreground)
            }
        }
        .onAppear {
            AppAnalytics.shared.ScreenVisit(screen: AppAnalytics.shared.mapDetailsScreen)
        }
        .onDisappear {
            AppAnalytics.shared.MapDetailsBackClick(map: map)
        }
    }
}

extension MapDetailsView {
    
    var mapName: some View {
        StatsCellView(label: "Name", icon: nil, value: map.displayName)
    }
    
    var mapCoordinates: some View {
        StatsCellView(label: "Coordinates", icon: nil, value: map.coordinates ?? "")
    }
    
    var mapDescription: some View {
        VStack(spacing: 3) {
            Group {
                Text("Description: ")
                    .foregroundStyle(KeyVariables.primaryColor)
                    .font(Font.custom(KeyVariables.primaryFont, size: 20))
                + Text(map.narrativeDescription ?? "")
                    .foregroundStyle(.foreground)
                    .font(Font.custom(KeyVariables.primaryFont, size: 15))
            }
            .multilineTextAlignment(.leading)
            
            Rectangle()
                .foregroundStyle(.foreground)
                .frame(height: 2)
        }
    }
}

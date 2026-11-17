//
//  MapModel.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 17/11/26.
//

import Foundation
import SwiftData

@Model
final class MapModel: CachedModel {
    @Attribute(.unique) var uuid: String
    var sortIndex: Int
    var displayName: String
    var narrativeDescription: String?
    var coordinates: String?
    var displayIcon: String?
    var listViewIcon: String?
    var splash: String
    var stylizedBackgroundImage: String?
    
    init(entity map: GameMap, sortIndex: Int) {
        self.uuid = map.uuid
        self.sortIndex = sortIndex
        self.displayName = map.displayName
        self.narrativeDescription = map.narrativeDescription
        self.coordinates = map.coordinates
        self.displayIcon = map.displayIcon
        self.listViewIcon = map.listViewIcon
        self.splash = map.splash
        self.stylizedBackgroundImage = map.stylizedBackgroundImage
    }
    
    var entity: GameMap {
        GameMap(uuid: uuid,
                displayName: displayName,
                narrativeDescription: narrativeDescription,
                coordinates: coordinates,
                displayIcon: displayIcon,
                listViewIcon: listViewIcon,
                splash: splash,
                stylizedBackgroundImage: stylizedBackgroundImage)
    }
}

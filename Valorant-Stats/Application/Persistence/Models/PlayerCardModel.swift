//
//  PlayerCardModel.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 17/11/26.
//

import Foundation
import SwiftData

@Model
final class PlayerCardModel: CachedModel {
    @Attribute(.unique) var uuid: String
    var sortIndex: Int
    var displayName: String
    var wideArt: String?
    var largeArt: String?
    
    init(entity card: PlayerCard, sortIndex: Int) {
        self.uuid = card.uuid
        self.sortIndex = sortIndex
        self.displayName = card.displayName
        self.wideArt = card.wideArt
        self.largeArt = card.largeArt
    }
    
    var entity: PlayerCard {
        PlayerCard(uuid: uuid, displayName: displayName, wideArt: wideArt, largeArt: largeArt)
    }
}

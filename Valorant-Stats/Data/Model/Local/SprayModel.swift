//
//  SprayModel.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 17/11/26.
//

import Foundation
import SwiftData

@Model
final class SprayModel: CachedModel {
    @Attribute(.unique) var uuid: String
    var sortIndex: Int
    var displayName: String
    var isNullSpray: Bool
    var fullTransparentIcon: String?
    var animationPng: String?
    var animationGif: String?
    
    init(entity spray: Spray, sortIndex: Int) {
        self.uuid = spray.uuid
        self.sortIndex = sortIndex
        self.displayName = spray.displayName
        self.isNullSpray = spray.isNullSpray
        self.fullTransparentIcon = spray.fullTransparentIcon
        self.animationPng = spray.animationPng
        self.animationGif = spray.animationGif
    }
    
    var entity: Spray {
        Spray(uuid: uuid,
              displayName: displayName,
              isNullSpray: isNullSpray,
              fullTransparentIcon: fullTransparentIcon,
              animationPng: animationPng,
              animationGif: animationGif)
    }
}

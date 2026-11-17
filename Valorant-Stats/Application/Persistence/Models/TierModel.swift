//
//  TierModel.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 17/11/26.
//

import Foundation
import SwiftData

/// Tiers have no identifier in the API, so they are not uniqued; the cache is
/// replaced wholesale on every successful fetch.
@Model
final class TierModel: CachedModel {
    var sortIndex: Int
    var tierName: String
    var color: String
    var backgroundColor: String
    var smallIcon: String?
    var largeIcon: String?
    
    init(entity tier: Tier, sortIndex: Int) {
        self.sortIndex = sortIndex
        self.tierName = tier.tierName
        self.color = tier.color
        self.backgroundColor = tier.backgroundColor
        self.smallIcon = tier.smallIcon
        self.largeIcon = tier.largeIcon
    }
    
    var entity: Tier {
        Tier(tierName: tierName,
             color: color,
             backgroundColor: backgroundColor,
             smallIcon: smallIcon,
             largeIcon: largeIcon)
    }
}

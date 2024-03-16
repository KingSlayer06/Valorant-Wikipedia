//
//  RankModelExtension.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 16/03/24.
//

import Foundation

extension TierModel {
    
    func getTier() -> Tier {
        return Tier(tierName: self.tierName!,
                    color: self.color!,
                    backgroundColor: self.backgroundColor!,
                    smallIcon: self.smallIcon,
                    largeIcon: self.largeIcon)
    }
}

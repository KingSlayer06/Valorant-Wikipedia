//
//  Rank.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 02/03/24.
//

import Foundation

struct Rank: Codable, Hashable {
    let uuid: String
    let tiers: [Tier]
}

struct Tier: Codable, Hashable {
    let tierName: String
    let color: String
    let backgroundColor: String
    let smallIcon: String?
    let largeIcon: String?
}

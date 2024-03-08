//
//  Bundle.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 07/03/24.
//

import Foundation

struct WeaponBundle: Codable {
    let uuid: String
    let displayName: String
    let displayIcon2: String
    let verticalPromoImage: String?
    let extraDescription: String?
}

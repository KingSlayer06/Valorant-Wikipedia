//
//  WeaponModel.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 17/11/26.
//

import Foundation
import SwiftData

@Model
final class WeaponModel: CachedModel {
    @Attribute(.unique) var uuid: String
    var sortIndex: Int
    var displayName: String
    var category: String
    var displayIcon: String
    var weaponStats: WeaponStats?
    var shopData: ShopData?
    var skins: [WeaponSkin]
    
    init(entity weapon: Weapon, sortIndex: Int) {
        self.uuid = weapon.uuid
        self.sortIndex = sortIndex
        self.displayName = weapon.displayName
        self.category = weapon.category
        self.displayIcon = weapon.displayIcon
        self.weaponStats = weapon.weaponStats
        self.shopData = weapon.shopData
        self.skins = weapon.skins
    }
    
    var entity: Weapon {
        Weapon(uuid: uuid,
               displayName: displayName,
               category: category,
               displayIcon: displayIcon,
               weaponStats: weaponStats,
               shopData: shopData,
               skins: skins)
    }
}

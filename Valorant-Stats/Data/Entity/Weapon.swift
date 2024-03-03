//
//  Weapon.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 26/02/24.
//

import Foundation

struct Weapon: Codable {
    let uuid: String
    let displayName: String
    let category: String
    let displayIcon: String
    let weaponStats: WeaponStats?
    let shopData: ShopData?
    var skins: [WeaponSkin]
}

struct WeaponStats: Codable {
    let fireRate: Float
    let magazineSize: Int32
    let damageRanges: [DamageRanges]
}

struct DamageRanges: Codable, Hashable {
    let rangeStartMeters: Int32
    let rangeEndMeters: Int32
    let headDamage: Float
    let bodyDamage: Float
    let legDamage: Float
}

struct ShopData: Codable {
    let cost: Int32
    let categoryText: String
}

struct WeaponSkin: Codable {
    let uuid: String
    let displayName: String
    let displayIcon: String?
    let chromas: [WeaponSkinChromas]
    let levels: [WeaponSkinLevel]
}

struct WeaponSkinChromas: Codable, Hashable {
    let uuid: String
    let displayName: String
    let fullRender: String?
    let swatch: String?
    let streamedVideo: String?
}

struct WeaponSkinLevel: Codable, Hashable {
    let uuid: String
    let displayName: String
    let displayIcon: String?
    let streamedVideo: String?
}

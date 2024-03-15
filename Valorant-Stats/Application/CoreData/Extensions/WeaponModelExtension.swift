//
//  WeaponModelExtension.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 15/03/24.
//

import Foundation

extension WeaponModel {
    
    func getWeapon() -> Weapon {
        return Weapon(uuid: self.uuid!,
                      displayName: self.displayName!,
                      category: self.category!,
                      displayIcon: self.displayIcon!,
                      weaponStats: self.weaponStats?.getWeaponStats(),
                      shopData: self.shopData?.getShopData(),
                      skins: self.gerWeaponSkins())
    }
    
    private func gerWeaponSkins() -> [WeaponSkin] {
        guard self.skins != nil else { return [] }
        
        var weaponSkins = [WeaponSkin]()
        
        self.skins?.forEach { skin in
            let weaponSkin = (skin as! WeaponSkinModel).getWeaponSkinModel()
            weaponSkins.append(weaponSkin)
        }
        
        return weaponSkins
    }
}

extension WeaponStatsModel {
    
    func getWeaponStats() -> WeaponStats {
        return WeaponStats(fireRate: self.fireRate,
                           magazineSize: self.magazineSize,
                           damageRanges: self.getDamageRanges())
    }
    
    private func getDamageRanges() -> [DamageRanges] {
        guard self.damageRanges != nil else { return [] }
        
        var weaponDamageRanges = [DamageRanges]()
        
        self.damageRanges?.forEach { damageRange in
            let weaponDamageRange = (damageRange as! DamageRangesModel).getDamageRangesModel()
            weaponDamageRanges.append(weaponDamageRange)
        }
        
        return weaponDamageRanges
    }
}

extension DamageRangesModel {
    
    func getDamageRangesModel() -> DamageRanges {
        return DamageRanges(rangeStartMeters: self.rangeStartMeters,
                            rangeEndMeters: self.rangeEndMeters,
                            headDamage: self.headDamage,
                            bodyDamage: self.bodyDamage,
                            legDamage: self.legDamage)
    }
}

extension ShopDataModel {
    
    func getShopData() -> ShopData {
        return ShopData(cost: self.cost,
                        categoryText: self.categoryText!)
    }
}

extension WeaponSkinModel {
    
    func getWeaponSkinModel() -> WeaponSkin {
        return WeaponSkin(uuid: self.uuid!,
                          displayName: self.displayName!,
                          displayIcon: self.displayIcon,
                          chromas: self.getWeaponSkinChromas(),
                          levels: self.getWeaponSkinLevels())
    }
    
    private func getWeaponSkinChromas() -> [WeaponSkinChromas] {
        guard self.chromas != nil else { return [] }
        
        var weaponSkinChromas = [WeaponSkinChromas]()
        
        self.chromas?.forEach { chroma in
            let weaponSkinChroma = (chroma as! WeaponSkinChromasModel).getWeaponSkinChromasModel()
            weaponSkinChromas.append(weaponSkinChroma)
        }
        
        return weaponSkinChromas
    }
    
    private func getWeaponSkinLevels() -> [WeaponSkinLevel] {
        guard self.levels != nil else { return [] }
        
        var weaponSkinLevels = [WeaponSkinLevel]()
        
        self.levels?.forEach { level in
            let weaponSkinLevel = (level as! WeaponSkinLevelModel).getWeaponSkinLevelModel()
            weaponSkinLevels.append(weaponSkinLevel)
        }
        
        return weaponSkinLevels
    }
}

extension WeaponSkinChromasModel {
    
    func getWeaponSkinChromasModel() -> WeaponSkinChromas {
        return WeaponSkinChromas(uuid: self.uuid!,
                                 displayName: self.displayName!,
                                 fullRender: self.fullRender,
                                 swatch: self.swatch,
                                 streamedVideo: self.streamedVideo)
    }
}

extension WeaponSkinLevelModel {
    
    func getWeaponSkinLevelModel() -> WeaponSkinLevel {
        return WeaponSkinLevel(uuid: self.uuid!,
                               displayName: self.displayName!,
                               displayIcon: self.displayIcon,
                               streamedVideo: self.streamedVideo)
    }
}

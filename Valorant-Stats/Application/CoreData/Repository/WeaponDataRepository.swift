//
//  WeaponDataRepository.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 15/03/24.
//

import Foundation
import CoreData

protocol PWeaponDataRepository: PBaseRepository {

}

final class WeaponDataRepository: PWeaponDataRepository {
    
    typealias T = Weapon
    
    var context: NSManagedObjectContext {
        return CoreDataStack.shared.weaponContext
    }
    
    func add(_ item: Weapon) {
        let _weapon = WeaponModel(context: context)
        _weapon.uuid = item.uuid
        _weapon.displayName = item.displayName
        _weapon.displayIcon = item.displayIcon
        _weapon.category = item.category
        
        if let weaponStats = item.weaponStats {
            let _weaponStats = WeaponStatsModel(context: context)
            _weaponStats.uuid = UUID()
            _weaponStats.fireRate = weaponStats.fireRate
            _weaponStats.magazineSize = weaponStats.magazineSize
            
            var _damageRanges = [DamageRangesModel]()
            for damageRange in weaponStats.damageRanges {
                let _damageRange = DamageRangesModel(context: context)
                _damageRange.uuid = UUID()
                _damageRange.rangeStartMeters = damageRange.rangeStartMeters
                _damageRange.rangeEndMeters = damageRange.rangeEndMeters
                _damageRange.headDamage = damageRange.headDamage
                _damageRange.bodyDamage = damageRange.bodyDamage
                _damageRange.legDamage = damageRange.legDamage
                
                _damageRanges.append(_damageRange)
            }
            _weaponStats.damageRanges = NSOrderedSet(array: _damageRanges)
            
            _weapon.weaponStats = _weaponStats
        }
        
        if let shopData = item.shopData {
            let _shopData = ShopDataModel(context: context)
            _shopData.uuid = UUID()
            _shopData.cost = shopData.cost
            _shopData.categoryText = shopData.categoryText
            
            _weapon.shopData = _shopData
        }
        
        var _skins = [WeaponSkinModel]()
        for skin in item.skins {
            let _skin = WeaponSkinModel(context: context)
            _skin.uuid = skin.uuid
            _skin.displayName = skin.displayName
            _skin.displayIcon = skin.displayIcon
            
            var _chromas = [WeaponSkinChromasModel]()
            for chroma in skin.chromas {
                let _chroma = WeaponSkinChromasModel(context: context)
                _chroma.uuid = chroma.uuid
                _chroma.displayName = chroma.displayName
                _chroma.fullRender = chroma.fullRender
                _chroma.swatch = chroma.swatch
                _chroma.streamedVideo = chroma.streamedVideo
                
                _chromas.append(_chroma)
            }
            _skin.chromas = NSOrderedSet(array: _chromas)
            
            var _levels = [WeaponSkinLevelModel]()
            for level in skin.levels {
                let _level = WeaponSkinLevelModel(context: context)
                _level.uuid = level.uuid
                _level.displayName = level.displayName
                _level.displayIcon = level.displayIcon
                _level.streamedVideo = level.streamedVideo
                
                _levels.append(_level)
            }
            _skin.levels = NSOrderedSet(array: _levels)
            
            _skins.append(_skin)
        }
        
        _weapon.skins = NSOrderedSet(array: _skins)
        
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    func save() {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
            print("Weapon saved successfully")
        } catch {
            print("Failed to save weapon:", error.localizedDescription)
        }
    }
    
    func getAll() -> [Weapon] {
        return []
    }
}

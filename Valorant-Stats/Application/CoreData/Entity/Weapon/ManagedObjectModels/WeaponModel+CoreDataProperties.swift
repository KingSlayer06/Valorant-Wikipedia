//
//  WeaponModel+CoreDataProperties.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 15/03/24.
//
//

import Foundation
import CoreData


extension WeaponModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeaponModel> {
        return NSFetchRequest<WeaponModel>(entityName: "WeaponModel")
    }

    @NSManaged public var category: String?
    @NSManaged public var displayIcon: String?
    @NSManaged public var displayName: String?
    @NSManaged public var uuid: String?
    @NSManaged public var shopData: ShopDataModel?
    @NSManaged public var skins: NSOrderedSet?
    @NSManaged public var weaponStats: WeaponStatsModel?

}

// MARK: Generated accessors for skins
extension WeaponModel {

    @objc(insertObject:inSkinsAtIndex:)
    @NSManaged public func insertIntoSkins(_ value: WeaponSkinModel, at idx: Int)

    @objc(removeObjectFromSkinsAtIndex:)
    @NSManaged public func removeFromSkins(at idx: Int)

    @objc(insertSkins:atIndexes:)
    @NSManaged public func insertIntoSkins(_ values: [WeaponSkinModel], at indexes: NSIndexSet)

    @objc(removeSkinsAtIndexes:)
    @NSManaged public func removeFromSkins(at indexes: NSIndexSet)

    @objc(replaceObjectInSkinsAtIndex:withObject:)
    @NSManaged public func replaceSkins(at idx: Int, with value: WeaponSkinModel)

    @objc(replaceSkinsAtIndexes:withSkins:)
    @NSManaged public func replaceSkins(at indexes: NSIndexSet, with values: [WeaponSkinModel])

    @objc(addSkinsObject:)
    @NSManaged public func addToSkins(_ value: WeaponSkinModel)

    @objc(removeSkinsObject:)
    @NSManaged public func removeFromSkins(_ value: WeaponSkinModel)

    @objc(addSkins:)
    @NSManaged public func addToSkins(_ values: NSOrderedSet)

    @objc(removeSkins:)
    @NSManaged public func removeFromSkins(_ values: NSOrderedSet)

}

extension WeaponModel : Identifiable {

}

//
//  WeaponStatsModel+CoreDataProperties.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 15/03/24.
//
//

import Foundation
import CoreData


extension WeaponStatsModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeaponStatsModel> {
        return NSFetchRequest<WeaponStatsModel>(entityName: "WeaponStatsModel")
    }

    @NSManaged public var fireRate: Float
    @NSManaged public var magazineSize: Int32
    @NSManaged public var uuid: UUID?
    @NSManaged public var damageRanges: NSOrderedSet?
    @NSManaged public var weapon: WeaponModel?

}

// MARK: Generated accessors for damageRanges
extension WeaponStatsModel {

    @objc(insertObject:inDamageRangesAtIndex:)
    @NSManaged public func insertIntoDamageRanges(_ value: DamageRangesModel, at idx: Int)

    @objc(removeObjectFromDamageRangesAtIndex:)
    @NSManaged public func removeFromDamageRanges(at idx: Int)

    @objc(insertDamageRanges:atIndexes:)
    @NSManaged public func insertIntoDamageRanges(_ values: [DamageRangesModel], at indexes: NSIndexSet)

    @objc(removeDamageRangesAtIndexes:)
    @NSManaged public func removeFromDamageRanges(at indexes: NSIndexSet)

    @objc(replaceObjectInDamageRangesAtIndex:withObject:)
    @NSManaged public func replaceDamageRanges(at idx: Int, with value: DamageRangesModel)

    @objc(replaceDamageRangesAtIndexes:withDamageRanges:)
    @NSManaged public func replaceDamageRanges(at indexes: NSIndexSet, with values: [DamageRangesModel])

    @objc(addDamageRangesObject:)
    @NSManaged public func addToDamageRanges(_ value: DamageRangesModel)

    @objc(removeDamageRangesObject:)
    @NSManaged public func removeFromDamageRanges(_ value: DamageRangesModel)

    @objc(addDamageRanges:)
    @NSManaged public func addToDamageRanges(_ values: NSOrderedSet)

    @objc(removeDamageRanges:)
    @NSManaged public func removeFromDamageRanges(_ values: NSOrderedSet)

}

extension WeaponStatsModel : Identifiable {

}

//
//  WeaponSkinModel+CoreDataProperties.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 15/03/24.
//
//

import Foundation
import CoreData


extension WeaponSkinModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeaponSkinModel> {
        return NSFetchRequest<WeaponSkinModel>(entityName: "WeaponSkinModel")
    }

    @NSManaged public var displayIcon: String?
    @NSManaged public var displayName: String?
    @NSManaged public var uuid: String?
    @NSManaged public var chromas: NSOrderedSet?
    @NSManaged public var levels: NSOrderedSet?
    @NSManaged public var weapon: WeaponModel?

}

// MARK: Generated accessors for chromas
extension WeaponSkinModel {

    @objc(insertObject:inChromasAtIndex:)
    @NSManaged public func insertIntoChromas(_ value: WeaponSkinChromasModel, at idx: Int)

    @objc(removeObjectFromChromasAtIndex:)
    @NSManaged public func removeFromChromas(at idx: Int)

    @objc(insertChromas:atIndexes:)
    @NSManaged public func insertIntoChromas(_ values: [WeaponSkinChromasModel], at indexes: NSIndexSet)

    @objc(removeChromasAtIndexes:)
    @NSManaged public func removeFromChromas(at indexes: NSIndexSet)

    @objc(replaceObjectInChromasAtIndex:withObject:)
    @NSManaged public func replaceChromas(at idx: Int, with value: WeaponSkinChromasModel)

    @objc(replaceChromasAtIndexes:withChromas:)
    @NSManaged public func replaceChromas(at indexes: NSIndexSet, with values: [WeaponSkinChromasModel])

    @objc(addChromasObject:)
    @NSManaged public func addToChromas(_ value: WeaponSkinChromasModel)

    @objc(removeChromasObject:)
    @NSManaged public func removeFromChromas(_ value: WeaponSkinChromasModel)

    @objc(addChromas:)
    @NSManaged public func addToChromas(_ values: NSOrderedSet)

    @objc(removeChromas:)
    @NSManaged public func removeFromChromas(_ values: NSOrderedSet)

}

// MARK: Generated accessors for levels
extension WeaponSkinModel {

    @objc(insertObject:inLevelsAtIndex:)
    @NSManaged public func insertIntoLevels(_ value: WeaponSkinLevelModel, at idx: Int)

    @objc(removeObjectFromLevelsAtIndex:)
    @NSManaged public func removeFromLevels(at idx: Int)

    @objc(insertLevels:atIndexes:)
    @NSManaged public func insertIntoLevels(_ values: [WeaponSkinLevelModel], at indexes: NSIndexSet)

    @objc(removeLevelsAtIndexes:)
    @NSManaged public func removeFromLevels(at indexes: NSIndexSet)

    @objc(replaceObjectInLevelsAtIndex:withObject:)
    @NSManaged public func replaceLevels(at idx: Int, with value: WeaponSkinLevelModel)

    @objc(replaceLevelsAtIndexes:withLevels:)
    @NSManaged public func replaceLevels(at indexes: NSIndexSet, with values: [WeaponSkinLevelModel])

    @objc(addLevelsObject:)
    @NSManaged public func addToLevels(_ value: WeaponSkinLevelModel)

    @objc(removeLevelsObject:)
    @NSManaged public func removeFromLevels(_ value: WeaponSkinLevelModel)

    @objc(addLevels:)
    @NSManaged public func addToLevels(_ values: NSOrderedSet)

    @objc(removeLevels:)
    @NSManaged public func removeFromLevels(_ values: NSOrderedSet)

}

extension WeaponSkinModel : Identifiable {

}

//
//  AgentModel+CoreDataProperties.swift
//  
//
//  Created by Himanshu Sherkar on 15/03/24.
//
//

import Foundation
import CoreData


extension AgentModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AgentModel> {
        return NSFetchRequest<AgentModel>(entityName: "AgentModel")
    }

    @NSManaged public var displayName: String?
    @NSManaged public var uuid: String?
    @NSManaged public var desc: String?
    @NSManaged public var displayIcon: String?
    @NSManaged public var fullPortrait: String?
    @NSManaged public var background: String?
    @NSManaged public var isPlayableCharacter: Bool
    @NSManaged public var role: AgentRoleModel?
    @NSManaged public var abilities: NSOrderedSet?

}

// MARK: Generated accessors for abilities
extension AgentModel {

    @objc(insertObject:inAbilitiesAtIndex:)
    @NSManaged public func insertIntoAbilities(_ value: AgentAbilitiesModel, at idx: Int)

    @objc(removeObjectFromAbilitiesAtIndex:)
    @NSManaged public func removeFromAbilities(at idx: Int)

    @objc(insertAbilities:atIndexes:)
    @NSManaged public func insertIntoAbilities(_ values: [AgentAbilitiesModel], at indexes: NSIndexSet)

    @objc(removeAbilitiesAtIndexes:)
    @NSManaged public func removeFromAbilities(at indexes: NSIndexSet)

    @objc(replaceObjectInAbilitiesAtIndex:withObject:)
    @NSManaged public func replaceAbilities(at idx: Int, with value: AgentAbilitiesModel)

    @objc(replaceAbilitiesAtIndexes:withAbilities:)
    @NSManaged public func replaceAbilities(at indexes: NSIndexSet, with values: [AgentAbilitiesModel])

    @objc(addAbilitiesObject:)
    @NSManaged public func addToAbilities(_ value: AgentAbilitiesModel)

    @objc(removeAbilitiesObject:)
    @NSManaged public func removeFromAbilities(_ value: AgentAbilitiesModel)

    @objc(addAbilities:)
    @NSManaged public func addToAbilities(_ values: NSOrderedSet)

    @objc(removeAbilities:)
    @NSManaged public func removeFromAbilities(_ values: NSOrderedSet)

}

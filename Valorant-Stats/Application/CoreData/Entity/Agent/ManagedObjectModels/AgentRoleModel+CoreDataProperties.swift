//
//  AgentRoleModel+CoreDataProperties.swift
//  
//
//  Created by Himanshu Sherkar on 15/03/24.
//
//

import Foundation
import CoreData


extension AgentRoleModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AgentRoleModel> {
        return NSFetchRequest<AgentRoleModel>(entityName: "AgentRoleModel")
    }

    @NSManaged public var uuid: String?
    @NSManaged public var displayName: String?
    @NSManaged public var displayIcon: String?
    @NSManaged public var agent: NSSet?

}

// MARK: Generated accessors for agent
extension AgentRoleModel {

    @objc(addAgentObject:)
    @NSManaged public func addToAgent(_ value: AgentModel)

    @objc(removeAgentObject:)
    @NSManaged public func removeFromAgent(_ value: AgentModel)

    @objc(addAgent:)
    @NSManaged public func addToAgent(_ values: NSSet)

    @objc(removeAgent:)
    @NSManaged public func removeFromAgent(_ values: NSSet)

}

//
//  AgentAbilitiesModel+CoreDataProperties.swift
//  
//
//  Created by Himanshu Sherkar on 15/03/24.
//
//

import Foundation
import CoreData


extension AgentAbilitiesModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AgentAbilitiesModel> {
        return NSFetchRequest<AgentAbilitiesModel>(entityName: "AgentAbilitiesModel")
    }

    @NSManaged public var displayName: String?
    @NSManaged public var desc: String?
    @NSManaged public var displayIcon: String?
    @NSManaged public var agent: AgentModel?

}

//
//  DamageRangesModel+CoreDataProperties.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 15/03/24.
//
//

import Foundation
import CoreData


extension DamageRangesModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DamageRangesModel> {
        return NSFetchRequest<DamageRangesModel>(entityName: "DamageRangesModel")
    }

    @NSManaged public var bodyDamage: Float
    @NSManaged public var headDamage: Float
    @NSManaged public var legDamage: Float
    @NSManaged public var rangeEndMeters: Int32
    @NSManaged public var rangeStartMeters: Int32
    @NSManaged public var uuid: UUID?
    @NSManaged public var weaponStats: WeaponStatsModel?

}

extension DamageRangesModel : Identifiable {

}

//
//  ShopDataModel+CoreDataProperties.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 15/03/24.
//
//

import Foundation
import CoreData


extension ShopDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShopDataModel> {
        return NSFetchRequest<ShopDataModel>(entityName: "ShopDataModel")
    }

    @NSManaged public var categoryText: String?
    @NSManaged public var cost: Int32
    @NSManaged public var uuid: UUID?
    @NSManaged public var weapon: WeaponModel?

}

extension ShopDataModel : Identifiable {

}

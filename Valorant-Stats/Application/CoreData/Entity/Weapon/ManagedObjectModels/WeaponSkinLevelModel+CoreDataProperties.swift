//
//  WeaponSkinLevelModel+CoreDataProperties.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 15/03/24.
//
//

import Foundation
import CoreData


extension WeaponSkinLevelModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeaponSkinLevelModel> {
        return NSFetchRequest<WeaponSkinLevelModel>(entityName: "WeaponSkinLevelModel")
    }

    @NSManaged public var displayIcon: String?
    @NSManaged public var displayName: String?
    @NSManaged public var streamedVideo: String?
    @NSManaged public var uuid: String?
    @NSManaged public var weaponSkin: WeaponSkinModel?

}

extension WeaponSkinLevelModel : Identifiable {

}

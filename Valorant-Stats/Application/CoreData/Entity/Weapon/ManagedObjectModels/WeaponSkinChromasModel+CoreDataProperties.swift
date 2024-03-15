//
//  WeaponSkinChromasModel+CoreDataProperties.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 15/03/24.
//
//

import Foundation
import CoreData


extension WeaponSkinChromasModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeaponSkinChromasModel> {
        return NSFetchRequest<WeaponSkinChromasModel>(entityName: "WeaponSkinChromasModel")
    }

    @NSManaged public var displayName: String?
    @NSManaged public var fullRender: String?
    @NSManaged public var streamedVideo: String?
    @NSManaged public var swatch: String?
    @NSManaged public var uuid: String?
    @NSManaged public var weaponSkin: WeaponSkinModel?

}

extension WeaponSkinChromasModel : Identifiable {

}

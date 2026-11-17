//
//  BundleModel.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 17/11/26.
//

import Foundation
import SwiftData

@Model
final class BundleModel: CachedModel {
    @Attribute(.unique) var uuid: String
    var sortIndex: Int
    var displayName: String
    var displayIcon2: String
    var verticalPromoImage: String?
    var extraDescription: String?
    
    init(entity bundle: WeaponBundle, sortIndex: Int) {
        self.uuid = bundle.uuid
        self.sortIndex = sortIndex
        self.displayName = bundle.displayName
        self.displayIcon2 = bundle.displayIcon2
        self.verticalPromoImage = bundle.verticalPromoImage
        self.extraDescription = bundle.extraDescription
    }
    
    var entity: WeaponBundle {
        WeaponBundle(uuid: uuid,
                     displayName: displayName,
                     displayIcon2: displayIcon2,
                     verticalPromoImage: verticalPromoImage,
                     extraDescription: extraDescription)
    }
}

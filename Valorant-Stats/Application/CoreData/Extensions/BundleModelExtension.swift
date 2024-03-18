//
//  BundleModelExtension.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 18/03/24.
//

import Foundation

extension BundleModel {
    
    func getBundle() -> WeaponBundle {
        return WeaponBundle(uuid: self.uuid!, 
                            displayName: self.displayName!,
                            displayIcon2: self.displayIcon2!,
                            verticalPromoImage: self.verticalPromoImage,
                            extraDescription: self.extraDescription)
    }
}

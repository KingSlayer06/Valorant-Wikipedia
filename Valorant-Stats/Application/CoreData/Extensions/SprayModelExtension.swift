//
//  SprayModelExtension.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 15/03/24.
//

import Foundation

extension SprayModel {
    
    func getSpray() -> Spray {
        return Spray(uuid: self.uuid!,
                     displayName: self.displayName!,
                     isNullSpray: self.isNullSpray,
                     fullTransparentIcon: self.fullTransparentIcon,
                     animationPng: self.fullTransparentIcon,
                     animationGif: self.animationGif)
    }
}

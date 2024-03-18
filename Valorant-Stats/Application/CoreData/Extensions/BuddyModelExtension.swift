//
//  BuddyModelExtension.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 18/03/24.
//

import Foundation

extension BuddyModel {
    
    func getBuddy() -> Buddy {
        return Buddy(uuid: self.uuid!,
                     displayName: self.displayName!,
                     displayIcon: self.displayIcon!)
    }
}

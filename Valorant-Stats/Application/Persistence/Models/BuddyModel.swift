//
//  BuddyModel.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 17/11/26.
//

import Foundation
import SwiftData

@Model
final class BuddyModel: CachedModel {
    @Attribute(.unique) var uuid: String
    var sortIndex: Int
    var displayName: String
    var displayIcon: String
    
    init(entity buddy: Buddy, sortIndex: Int) {
        self.uuid = buddy.uuid
        self.sortIndex = sortIndex
        self.displayName = buddy.displayName
        self.displayIcon = buddy.displayIcon
    }
    
    var entity: Buddy {
        Buddy(uuid: uuid, displayName: displayName, displayIcon: displayIcon)
    }
}

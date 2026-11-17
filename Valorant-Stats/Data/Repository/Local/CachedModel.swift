//
//  CachedModel.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 17/11/26.
//

import Foundation
import SwiftData

protocol CachedModel: PersistentModel {
    associatedtype Entity

    var sortIndex: Int { get }
    var entity: Entity { get }

    init(entity: Entity, sortIndex: Int)
}

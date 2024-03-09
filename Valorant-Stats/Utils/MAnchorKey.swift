//
//  MAnchorKey.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 09/03/24.
//

import SwiftUI

struct MAnchorKey: PreferenceKey {
    static var defaultValue: [String : Anchor<CGRect>] = [:]
    
    static func reduce(value: inout [String : Anchor<CGRect>], nextValue: () -> [String : Anchor<CGRect>]) {
        return value.merge(nextValue()) { $1 }
    }
}

//
//  GetBundlesResponse.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 07/03/24.
//

import Foundation

struct GetBundlesResponse: Codable {
    let status: Int32
    let data: [WeaponBundle]
}

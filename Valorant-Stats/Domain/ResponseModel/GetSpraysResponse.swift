//
//  GetSpraysResponse.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 27/02/24.
//

import Foundation

struct GetSpraysResponse: Codable {
    let status: Int32
    let data: [Spray]
}

//
//  GetRanksResponse.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 02/03/24.
//

import Foundation

struct GetRanksResponse: Codable {
    let status: Int32
    let data: [Rank]
}

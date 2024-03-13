//
//  GetAgentsResponseModel.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 26/02/24.
//

import Foundation

struct GetAgentsResponse: Codable {
    let status: Int32
    let data: [Agent]
}

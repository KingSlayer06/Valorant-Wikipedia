//
//  GetPlayerTitlesResponse.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 13/03/24.
//

import Foundation

struct GetPlayerTitleByIdResponse: Codable {
    let status: Int32
    let data: PlayerTitle
}

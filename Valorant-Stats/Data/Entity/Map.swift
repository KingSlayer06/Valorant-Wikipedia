//
//  Map.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 26/02/24.
//

import Foundation

struct GameMap: Codable {
    let uuid: String
    let displayName: String
    let narrativeDescription: String?
    let coordinates: String?
    let displayIcon: String?
    let listViewIcon: String?
    let splash: String
    let stylizedBackgroundImage: String?
}

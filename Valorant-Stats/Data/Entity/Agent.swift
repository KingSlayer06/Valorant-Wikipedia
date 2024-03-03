//
//  Agent.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 26/02/24.
//

import Foundation

struct Agent: Codable {
    let uuid: String
    let displayName: String
    let description: String
    let displayIcon: String
    let fullPortrait: String?
    let background: String?
    let isPlayableCharacter: Bool
    let role: AgentRole?
    let abilities: [AgentAbilities]
}

struct AgentRole: Codable, Hashable {
    let uuid: String
    let displayName: String
    let displayIcon: String
}

struct AgentAbilities: Codable, Hashable {
    let displayName: String
    let description: String
    let displayIcon: String?
}

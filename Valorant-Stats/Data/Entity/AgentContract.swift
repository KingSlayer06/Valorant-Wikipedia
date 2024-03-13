//
//  Contract.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 13/03/24.
//

import Foundation

struct AgentContract: Codable {
    let uuid: String
    let displayName: String
    let content: ContractContent
}

struct ContractContent: Codable {
    let chapters: [ContractChapters]
}

struct ContractChapters: Codable {
    let isEpilogue: Bool?
    let levels: [ContractLevel]
}

struct ContractLevel: Codable {
    let reward: ContractReward
    let xp: Int32
    let vpCost: Int32
}

struct ContractReward: Codable {
    let type: String
    let uuid: String
    let amount: Int32
    let isHighlighted: Bool
}

//
//  SideMenuOptionsModel.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 26/02/24.
//

import Foundation

enum SideMenuOptionsModel: Int, CaseIterable {
    case home
    case agents
    case maps
    case weapons
    case playerCards
    case sprays
    case ranks
    case bundles
    case contracts
    case patchNotes
    
    var title: String {
        switch self {
            case .home:
                return "Home"
            case .agents:
                return "Agents"
            case .maps:
                return "Maps"
            case .weapons:
                return "Weapons"
            case .playerCards:
                return "Player Cards"
            case .sprays:
                return "Sprays"
            case .ranks:
                return "Ranks"
            case .bundles:
                return "Bundles"
            case .contracts:
                return "Agent Contracts"
            case .patchNotes:
                return "Patch Notes"
        }
    }
}

extension SideMenuOptionsModel: Identifiable {
    var id: Int { return self.rawValue }
}

let tabOptions: [SideMenuOptionsModel] = [.agents, .maps, .weapons]
let menuOptions: [SideMenuOptionsModel] = [.home, .bundles, .playerCards, .sprays, .ranks]


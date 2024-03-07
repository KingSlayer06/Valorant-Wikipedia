//
//  SideMenuOptionsModel.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 26/02/24.
//

import Foundation

enum SideMenuOptionsModel: Int, CaseIterable {
    case agents
    case maps
    case weapons
    case playerCards
    case sprays
    case ranks
    case patchNotes
//    case moreOptions
    
    var title: String {
        switch self {
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
            case .patchNotes:
                return "Patch Notes"
//        case .moreOptions:
//            return "More"
        }
    }
    
//    var image: String {
//        switch self {
//            case .agents:
//                return "agents-icon"
//            case .maps:
//                return "maps-icon"
//            case .weapons:
//                return "weapons-icon"
//            case .moreOptions:
//                return "more-icon"
//            default:
//                return ""
//        }
//    }
}

extension SideMenuOptionsModel: Identifiable {
    var id: Int { return self.rawValue }
}

//let tabOptions: [SideMenuOptionsModel] = [.agents, .maps, .weapons, .moreOptions]
let menuOptions: [SideMenuOptionsModel] = [.agents, .maps, .weapons, .playerCards, .sprays, .ranks]


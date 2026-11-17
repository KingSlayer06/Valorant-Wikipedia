//
//  AgentModel.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 17/11/26.
//

import Foundation
import SwiftData

@Model
final class AgentModel: CachedModel {
    @Attribute(.unique) var uuid: String
    var sortIndex: Int
    var displayName: String
    var agentDescription: String
    var displayIcon: String
    var fullPortrait: String?
    var background: String?
    var isPlayableCharacter: Bool
    var role: AgentRole?
    var abilities: [AgentAbilities]
    
    init(entity agent: Agent, sortIndex: Int) {
        self.uuid = agent.uuid
        self.sortIndex = sortIndex
        self.displayName = agent.displayName
        self.agentDescription = agent.description
        self.displayIcon = agent.displayIcon
        self.fullPortrait = agent.fullPortrait
        self.background = agent.background
        self.isPlayableCharacter = agent.isPlayableCharacter
        self.role = agent.role
        self.abilities = agent.abilities
    }
    
    var entity: Agent {
        Agent(uuid: uuid,
              displayName: displayName,
              description: agentDescription,
              displayIcon: displayIcon,
              fullPortrait: fullPortrait,
              background: background,
              isPlayableCharacter: isPlayableCharacter,
              role: role,
              abilities: abilities)
    }
}

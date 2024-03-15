//
//  AgentModelExtension.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 15/03/24.
//

import Foundation

extension AgentModel {
    
    func getAgent() -> Agent {
        return Agent(uuid: self.uuid!,
                     displayName: self.displayName!,
                     description: self.desc!,
                     displayIcon: self.displayIcon!,
                     fullPortrait: self.fullPortrait,
                     background: self.background,
                     isPlayableCharacter: self.isPlayableCharacter,
                     role: self.role?.getAgentRole(),
                     abilities: self.getAgentAbilities())
    }
    
    private func getAgentAbilities() -> [AgentAbilities] {
        guard self.abilities != nil else { return [] }
        
        var agentAbilities = [AgentAbilities]()
        
        self.abilities?.forEach { ability in
            let agentability = (ability as! AgentAbilitiesModel).getAgentAbilities()
            agentAbilities.append(agentability)
        }
        
        return agentAbilities
    }
}

extension AgentRoleModel {
    
    func getAgentRole() -> AgentRole {
        return AgentRole(uuid: self.uuid!,
                         displayName: self.displayName!,
                         displayIcon: self.displayIcon!)
    }
}

extension AgentAbilitiesModel {
    
    func getAgentAbilities() -> AgentAbilities {
        return AgentAbilities(displayName: self.displayName!,
                              description: self.desc!,
                              displayIcon: self.displayIcon)
    }
}

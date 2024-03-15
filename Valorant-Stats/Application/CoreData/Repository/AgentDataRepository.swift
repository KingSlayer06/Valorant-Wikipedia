//
//  AgentDataRepository.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 15/03/24.
//

import Foundation
import CoreData

protocol PAgentDataRepository {
    func add(agent: Agent)
}

final class AgentDataRepository: PAgentDataRepository {
    
    var context: NSManagedObjectContext {
        return CoreDataStack.shared.context
    }
    
    func add(agent: Agent) {
        let _agent = AgentModel(context: context)
        _agent.uuid = agent.uuid
        _agent.displayName = agent.displayName
        _agent.desc = agent.description
        _agent.displayIcon = agent.displayIcon
        _agent.fullPortrait = agent.fullPortrait
        _agent.background = agent.background
        _agent.isPlayableCharacter = agent.isPlayableCharacter
        
        if let agentRole = agent.role {
            let _agentRole = AgentRoleModel(context: context)
            _agentRole.uuid = agentRole.uuid
            _agentRole.displayName = agentRole.displayName
            _agentRole.displayIcon = agentRole.displayIcon
            
            _agent.role = _agentRole
        }
        
        var _abilities = [AgentAbilitiesModel]()
        for ability in agent.abilities {
            let _agentAbility = AgentAbilitiesModel(context: context)
            _agentAbility.displayName = ability.displayName
            _agentAbility.displayIcon = ability.displayIcon
            _agentAbility.desc = ability.description
            
            _abilities.append(_agentAbility)
        }
        _agent.abilities = NSOrderedSet(array: _abilities)
        
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        CoreDataStack.shared.save()
    }
}

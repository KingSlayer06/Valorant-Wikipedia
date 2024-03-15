//
//  AgentDataRepository.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 15/03/24.
//

import Foundation
import CoreData

protocol PAgentDataRepository: PBaseRepository {

}

final class AgentDataRepository: PAgentDataRepository {
    
    typealias T = Agent
    
    var context: NSManagedObjectContext {
        return CoreDataStack.shared.agentContext
    }
    
    func add(_ item: Agent) {
        let _agent = AgentModel(context: context)
        _agent.uuid = item.uuid
        _agent.displayName = item.displayName
        _agent.desc = item.description
        _agent.displayIcon = item.displayIcon
        _agent.fullPortrait = item.fullPortrait
        _agent.background = item.background
        _agent.isPlayableCharacter = item.isPlayableCharacter
        
        if let agentRole = item.role {
            let _agentRole = AgentRoleModel(context: context)
            _agentRole.uuid = agentRole.uuid
            _agentRole.displayName = agentRole.displayName
            _agentRole.displayIcon = agentRole.displayIcon
            
            _agent.role = _agentRole
        }
        
        var _abilities = [AgentAbilitiesModel]()
        for ability in item.abilities {
            let _agentAbility = AgentAbilitiesModel(context: context)
            _agentAbility.displayName = ability.displayName
            _agentAbility.displayIcon = ability.displayIcon
            _agentAbility.desc = ability.description
            
            _abilities.append(_agentAbility)
        }
        _agent.abilities = NSOrderedSet(array: _abilities)
        
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    func save() {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
            print("Agents saved successfully")
        } catch {
            print("Failed to save agents:", error.localizedDescription)
        }
    }
    
    func getAll() -> [Agent] {
        guard let records = try? context.fetch(AgentModel.fetchRequest()) as? [AgentModel] else { return [] }
        
        var agents: [Agent] = []
        records.forEach { agentModel in
            agents.append(agentModel.getAgent())
        }
        
        print("Agents fetched successfully")
        
        return agents
    }
}

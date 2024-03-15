//
//  CoreDataStack.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 15/03/24.
//

import Foundation
import CoreData

class CoreDataStack: ObservableObject {
    static let shared = CoreDataStack()
    
    lazy var agentPersistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Agent")

        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to load agent persistent stores: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    lazy var weaponPersistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Weapon")

        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to load weapon persistent stores: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    lazy var agentContext = agentPersistentContainer.viewContext
    lazy var weaponContext = weaponPersistentContainer.viewContext
        
    private init() { }
}

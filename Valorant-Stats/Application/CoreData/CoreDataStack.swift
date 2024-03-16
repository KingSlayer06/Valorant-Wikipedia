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
    
    lazy var mapPersistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Map")

        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to load weapon persistent stores: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    lazy var playerCardPersistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "PlayerCard")

        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to load PlayerCard persistent stores: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    lazy var sprayPersistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Spray")

        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to load Spray persistent stores: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    lazy var tierPersistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Tier")

        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to load tier persistent stores: \(error.localizedDescription)")
            }
        }
        return container
    }()
        
    private init() { }
}

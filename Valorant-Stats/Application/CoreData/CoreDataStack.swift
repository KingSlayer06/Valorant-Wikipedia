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
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Agent")

        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
        
    private init() { }
}

extension CoreDataStack {
    
    func save() {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
            print("Context saved successfully")
        } catch {
            print("Failed to save the context:", error.localizedDescription)
        }
    }
}

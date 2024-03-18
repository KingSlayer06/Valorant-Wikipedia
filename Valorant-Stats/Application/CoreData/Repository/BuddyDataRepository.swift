//
//  BuddyDataRepository.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 18/03/24.
//

import Foundation
import CoreData

protocol PBuddyDataRepository: PBaseRepository {
    
}

final class BuddyDataRepository: PBuddyDataRepository {
    
    typealias T = Buddy
    
    var context: NSManagedObjectContext {
        return CoreDataStack.shared.buddyPersistentContainer.viewContext
    }
    
    func add(_ item: Buddy) {
        let _buddy = BuddyModel(context: context)
        _buddy.uuid = item.uuid
        _buddy.displayName = item.displayName
        _buddy.displayIcon = item.displayIcon
        
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    func save() {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
            print("Buddy saved successfully")
        } catch {
            print("Failed to save buddy:", error.localizedDescription)
        }
    }
    
    func getAll() -> [Buddy] {
        guard let records = try? context.fetch(BuddyModel.fetchRequest()) as? [BuddyModel] else { return [] }

        var buddies = [Buddy]()
        
        records.forEach { buddyModel in
            buddies.append(buddyModel.getBuddy())
        }
        
        return buddies
    }
}

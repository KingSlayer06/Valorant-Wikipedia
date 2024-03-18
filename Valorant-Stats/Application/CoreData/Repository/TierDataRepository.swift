//
//  RankDataRepository.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 16/03/24.
//

import Foundation
import CoreData

protocol PTierDataRepository: PBaseRepository {
    
}

final class TierDataRepository: PTierDataRepository {
    
    typealias T = Tier
    
    var context: NSManagedObjectContext {
        return CoreDataStack.shared.tierPersistentContainer.viewContext
    }
    
    func add(_ item: Tier) {
        let _tier = TierModel(context: context)
        _tier.uuid = UUID()
        _tier.tierName = item.tierName
        _tier.color = item.color
        _tier.backgroundColor = item.backgroundColor
        _tier.smallIcon = item.smallIcon
        _tier.largeIcon = item.largeIcon
        
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    func save() {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
            print("Tier saved successfully")
        } catch {
            print("Failed to save tier:", error.localizedDescription)
        }
    }
    
    func getAll() -> [Tier] {
        guard let records = try? context.fetch(TierModel.fetchRequest()) as? [TierModel] else { return [] }
        
        var tiers = [Tier]()
        
        records.forEach { tierModel in
            tiers.append(tierModel.getTier())
        }
        
        return tiers
    }
}

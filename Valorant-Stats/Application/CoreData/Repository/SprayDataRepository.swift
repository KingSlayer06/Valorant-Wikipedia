//
//  SprayDataRepository.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 15/03/24.
//

import Foundation
import CoreData

protocol PSprayDataRepository: PBaseRepository {
    
}

final class SprayDataRepository: PSprayDataRepository {
    
    typealias T = Spray
    
    var context: NSManagedObjectContext {
        return CoreDataStack.shared.sprayPersistentContainer.viewContext
    }
    
    func add(_ item: Spray) {
        let _spray = SprayModel(context: context)
        _spray.uuid = item.uuid
        _spray.displayName = item.displayName
        _spray.isNullSpray = item.isNullSpray
        _spray.fullTransparentIcon = item.fullTransparentIcon
        _spray.animationPng = item.animationPng
        _spray.animationGif = item.animationGif
        
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    func save() {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
            print("Spray saved successfully")
        } catch {
            print("Failed to save spray:", error.localizedDescription)
        }
    }
    
    func getAll() -> [Spray] {
        guard let records = try? context.fetch(SprayModel.fetchRequest()) as? [SprayModel] else { return [] }
        
        var sprays = [Spray]()
        
        records.forEach { sprayModel in
            sprays.append(sprayModel.getSpray())
        }
        
        return sprays
    }
}

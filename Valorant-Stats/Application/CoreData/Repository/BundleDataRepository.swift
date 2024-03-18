//
//  BundleDataRepository.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 18/03/24.
//

import Foundation
import CoreData

protocol PBundleDataRepository: PBaseRepository {
    
}

final class BundleDataRepository: PBundleDataRepository {
    
    typealias T = WeaponBundle
    
    var context: NSManagedObjectContext {
        return CoreDataStack.shared.bundlePersistentContainer.viewContext
    }
    
    func add(_ item: WeaponBundle) {
        let _bundle = BundleModel(context: context)
        _bundle.uuid = item.uuid
        _bundle.displayName = item.displayName
        _bundle.displayIcon2 = item.displayIcon2
        _bundle.verticalPromoImage = item.verticalPromoImage
        _bundle.extraDescription = item.extraDescription
        
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    func save() {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
            print("Bundle saved successfully")
        } catch {
            print("Failed to save bundle:", error.localizedDescription)
        }
    }
    
    func getAll() -> [WeaponBundle] {
        guard let records = try? context.fetch(BundleModel.fetchRequest()) as? [BundleModel] else { return [] }

        var bundles = [WeaponBundle]()
        
        records.forEach { bundleModel in
            bundles.append(bundleModel.getBundle())
        }
        
        return bundles
    }
}

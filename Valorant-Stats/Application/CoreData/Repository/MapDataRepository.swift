//
//  MapDataRepository.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 15/03/24.
//

import Foundation
import CoreData

protocol PMapDataRepository: PBaseRepository {
    
}

final class MapDataRepository: PMapDataRepository {
    
    typealias T = GameMap
    
    var context: NSManagedObjectContext {
        return CoreDataStack.shared.mapPersistentContainer.viewContext
    }
    
    func add(_ item: GameMap) {
        let _map = MapModel(context: context)
        _map.uuid = item.uuid
        _map.displayName = item.displayName
        _map.narrativeDescription = item.narrativeDescription
        _map.coordinates = item.coordinates
        _map.displayIcon = item.displayIcon
        _map.listViewIcon = item.listViewIcon
        _map.splash = item.splash
        _map.stylizedBackgroundImage = item.stylizedBackgroundImage
        
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    func save() {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
            print("Maps saved successfully")
        } catch {
            print("Failed to save maps:", error.localizedDescription)
        }
    }
    
    func getAll() -> [GameMap] {
        guard let records = try? context.fetch(MapModel.fetchRequest()) as? [MapModel] else { return [] }
        
        var maps = [GameMap]()
        records.forEach { mapModel in
            maps.append(mapModel.getMap())
        }
        
        return maps
    }
}

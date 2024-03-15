//
//  PlayerCardDataRepository.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 15/03/24.
//

import Foundation
import CoreData

protocol PPlayerCardDataRepository: PBaseRepository {
    
}

final class PlayerCardDataRepository: PPlayerCardDataRepository {
    
    typealias T = PlayerCard
    
    var context: NSManagedObjectContext {
        return CoreDataStack.shared.playerCardPersistentContainer.viewContext
    }
    
    func add(_ item: PlayerCard) {
        let _playerCard = PlayerCardModel(context: context)
        _playerCard.uuid = item.uuid
        _playerCard.displayName = item.displayName
        _playerCard.wideArt = item.wideArt
        _playerCard.largeArt = item.largeArt
        
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    func save() {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
            print("Player Cards saved successfully")
        } catch {
            print("Failed to save playerCards:", error.localizedDescription)
        }
    }
    
    func getAll() -> [PlayerCard] {
        guard let records = try? context.fetch(PlayerCardModel.fetchRequest()) as? [PlayerCardModel] else { return [] }
        
        var playerCards = [PlayerCard]()
        
        records.forEach { playerCardModel in
            playerCards.append(playerCardModel.getPlayerCard())
        }
        
        return playerCards
    }
}

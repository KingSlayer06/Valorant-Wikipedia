//
//  CacheRepository.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 17/11/26.
//

import Foundation
import SwiftData

actor CacheRepository<Model: CachedModel>: PCacheRepository, ModelActor {

    nonisolated let modelContainer: ModelContainer
    nonisolated let modelExecutor: any ModelExecutor

    init(modelContainer: ModelContainer = PersistenceController.shared) {
        self.modelContainer = modelContainer
        self.modelExecutor = DefaultSerialModelExecutor(modelContext: ModelContext(modelContainer))
    }

    func fetchAll() throws -> [Model.Entity] {
        do {
            return try modelContext.fetch(FetchDescriptor<Model>())
                .sorted { $0.sortIndex < $1.sortIndex }
                .map(\.entity)
        } catch {
            throw PersistenceError.fetchFailed(underlying: error)
        }
    }

    func replaceAll(with items: [Model.Entity]) throws {
        do {
            try modelContext.transaction {
                try modelContext.delete(model: Model.self)
                for (index, item) in items.enumerated() {
                    modelContext.insert(Model(entity: item, sortIndex: index))
                }
            }
            try modelContext.save()
            print("Saved \(items.count) \(Model.self) items")
        } catch {
            modelContext.rollback()
            throw PersistenceError.saveFailed(underlying: error)
        }
    }
}

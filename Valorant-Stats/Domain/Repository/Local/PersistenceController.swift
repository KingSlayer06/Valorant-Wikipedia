//
//  PersistenceController.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 17/11/26.
//

import Foundation
import SwiftData

enum PersistenceController {

    static let schema = Schema([
        AgentModel.self,
        WeaponModel.self,
        MapModel.self,
        PlayerCardModel.self,
        SprayModel.self,
        TierModel.self,
        BuddyModel.self,
        BundleModel.self,
    ])

    static let shared: ModelContainer = makeContainer()

    private static func makeContainer() -> ModelContainer {
        removeLegacyCoreDataStores()

        let configuration = ModelConfiguration("GameAssetsCache", schema: schema)

        do {
            return try ModelContainer(for: schema, configurations: configuration)
        } catch {
            // The store only caches API responses, so if it can't be opened (e.g. after an
            // incompatible schema change) it is safe to throw it away and start fresh.
            print("Failed to open SwiftData store, recreating it: \(error.localizedDescription)")
            removeStoreFiles(at: configuration.url)
        }

        do {
            return try ModelContainer(for: schema, configurations: configuration)
        } catch {
            print("Failed to recreate SwiftData store, falling back to in-memory: \(error.localizedDescription)")
            let inMemory = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
            do {
                return try ModelContainer(for: schema, configurations: inMemory)
            } catch {
                fatalError("Failed to create an in-memory ModelContainer: \(error)")
            }
        }
    }

    private static func removeStoreFiles(at url: URL) {
        for suffix in ["", "-shm", "-wal"] {
            try? FileManager.default.removeItem(at: URL(fileURLWithPath: url.path + suffix))
        }
    }

    private static func removeLegacyCoreDataStores() {
        guard let directory = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
            return
        }

        let legacyStoreNames = ["Agent", "Weapon", "Map", "PlayerCard", "Spray", "Tier", "Bundle", "Buddy"]
        for name in legacyStoreNames {
            let storeURL = directory.appendingPathComponent("\(name).sqlite")
            guard FileManager.default.fileExists(atPath: storeURL.path) else { continue }

            removeStoreFiles(at: storeURL)
            print("Removed legacy CoreData store \(name).sqlite")
        }
    }
}

//
//  GameAssetsCaches.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 17/11/26.
//

import Foundation
import SwiftData

/// The offline caches used by `HomeViewModel`, grouped so they can be injected
/// (e.g. in-memory fakes in tests and previews) without the ViewModel knowing about SwiftData.
struct GameAssetsCaches {
    var agents: any PCacheRepository<Agent>
    var weapons: any PCacheRepository<Weapon>
    var maps: any PCacheRepository<GameMap>
    var playerCards: any PCacheRepository<PlayerCard>
    var sprays: any PCacheRepository<Spray>
    var tiers: any PCacheRepository<Tier>
    var buddies: any PCacheRepository<Buddy>
    var bundles: any PCacheRepository<WeaponBundle>

    /// Caches backed by the shared SwiftData container.
    static func swiftData(container: ModelContainer = PersistenceController.shared) -> GameAssetsCaches {
        GameAssetsCaches(
            agents: CacheRepository<AgentModel>(modelContainer: container),
            weapons: CacheRepository<WeaponModel>(modelContainer: container),
            maps: CacheRepository<MapModel>(modelContainer: container),
            playerCards: CacheRepository<PlayerCardModel>(modelContainer: container),
            sprays: CacheRepository<SprayModel>(modelContainer: container),
            tiers: CacheRepository<TierModel>(modelContainer: container),
            buddies: CacheRepository<BuddyModel>(modelContainer: container),
            bundles: CacheRepository<BundleModel>(modelContainer: container)
        )
    }
}

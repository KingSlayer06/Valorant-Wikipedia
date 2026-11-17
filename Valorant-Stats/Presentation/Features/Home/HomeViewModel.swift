//
//  HomeViewModel.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 26/02/24.
//

import Foundation
import SwiftUI
import Kingfisher
//import SwiftWebP
import CoreImage

@MainActor
final class HomeViewModel: NSObject, ObservableObject {
    @Published var selectedTab: SideMenuOptionsModel = .home
    @Published var selectedBottomTab: SideMenuOptionsModel = .agents
    
    @Published var agents = [Agent]()
    @Published var weapons = [Weapon]()
    @Published var maps = [GameMap]()
    @Published var playerCards = [PlayerCard]()
    @Published var sprays = [Spray]()
    @Published var tiers = [Tier]()
    @Published var buddies = [Buddy]()
    @Published var bundles = [WeaponBundle]()
    @Published var contracts = [AgentContract]()
    
    @Published var shareImage: UIImage?
    @Published var showAlert: Bool = false
    @Published var alertText: String = ""
    
    @Published var contentLoadError: NetworkError?
    
    @Published var showAgentsShimmer: Bool = false
    @Published var showMapsShimmer: Bool = false
    @Published var showWeaponsShimmer: Bool = false
    @Published var showPlayerCardsShimmer: Bool = false
    @Published var showSpraysShimmer: Bool = false
    @Published var showRanksShimmer: Bool = false
    @Published var showBundlesShimmer: Bool = false
    @Published var showContractsShimmer: Bool = false
    
    var isShowingContentLoadError: Bool {
        get { contentLoadError != nil }
        set { if !newValue { contentLoadError = nil } }
    }
    
    private let getAgentsUseCase: PGetAgentsUseCase
    private let getWeaponsUseCase: PGetWeaponsUseCase
    private let getMapsUseCase: PGetMapsUseCase
    private let getPlayerCardsUseCase: PGetPlayerCardsUseCase
    private let getSpraysUseCase: PGetSpraysUseCase
    private let getRanksUseCase: PGetRanksUseCase
    private let getBuddiesUseCase: PGetBuddiesUseCase
    private let getBundlesUseCase: PGetBundlesUseCase
    private let getAgentsContractsUseCase: PGetAgentContractsUseCase
    
    // Offline caches
    private let caches: GameAssetsCaches
    
    init(
        gameAssetsRepo: PGameAssetsRepository = GameAssetsRepository(),
        caches: GameAssetsCaches = .localCache()
    ) {
        self.caches = caches
        self.getAgentsUseCase = GetAgentsUseCase(gameAssetsRepo: gameAssetsRepo)
        self.getWeaponsUseCase = GetWeaponsUseCase(gameAssetsRepo: gameAssetsRepo)
        self.getMapsUseCase = GetMapsUseCase(gameAssetsRepo: gameAssetsRepo)
        self.getPlayerCardsUseCase = GetPlayerCardsUseCase(gameAssetsRepo: gameAssetsRepo)
        self.getSpraysUseCase = GetSpraysUseCase(gameAssetsRepo: gameAssetsRepo)
        self.getRanksUseCase = GetRanksUseCase(gameAssetsRepo: gameAssetsRepo)
        self.getBuddiesUseCase = GetBuddiesUseCase(gameAssetsRepo: gameAssetsRepo)
        self.getBundlesUseCase = GetBundlesUseCase(gameAssetsRepo: gameAssetsRepo)
        self.getAgentsContractsUseCase = GetAgentContractsUseCase(gameAssetsRepo: gameAssetsRepo)
        
        super.init()
    }
    
    // MARK: - Content Loading
    func loadContent() async {
        let errors = await withTaskGroup(of: NetworkError?.self) { group in
            group.addTask { await self.loadAgents() }
            group.addTask { await self.loadWeapons() }
            group.addTask { await self.loadMaps() }
            group.addTask { await self.loadBuddies() }
            group.addTask { await self.loadPlayerCards() }
            group.addTask { await self.loadSprays() }
            group.addTask { await self.loadRanks() }
            group.addTask { await self.loadBundles() }
            group.addTask { await self.loadAgentContracts() }
            
            var errors = [NetworkError]()
            for await error in group {
                if let error { errors.append(error) }
            }
            return errors
        }
        
        guard !Task.isCancelled else { return }
        contentLoadError = errors.first
    }
    
    private func loadAgents() async -> NetworkError? {
        await loadSection(
            "agents",
            into: \.agents,
            shimmer: \.showAgentsShimmer,
            cache: caches.agents
        ) {
            try await self.getAgentsUseCase.execute().data
                .filter { $0.isPlayableCharacter == true }
        }
    }
    
    private func loadWeapons() async -> NetworkError? {
        await loadSection(
            "weapons",
            into: \.weapons,
            shimmer: \.showWeaponsShimmer,
            cache: caches.weapons
        ) {
            var weapons = try await self.getWeaponsUseCase.execute().data
            
            for index in weapons.indices {
                weapons[index].skins.removeAll(where: { $0.displayName == "Random Favorite Skin" ||
                    $0.displayName.contains("Standard") })
            }
            return weapons
        }
    }
    
    private func loadMaps() async -> NetworkError? {
        await loadSection(
            "maps",
            into: \.maps,
            shimmer: \.showMapsShimmer,
            cache: caches.maps
        ) {
            try await self.getMapsUseCase.execute().data
        }
    }
    
    private func loadPlayerCards() async -> NetworkError? {
        await loadSection(
            "player cards",
            into: \.playerCards,
            shimmer: \.showPlayerCardsShimmer,
            cache: caches.playerCards
        ) {
            try await self.getPlayerCardsUseCase.execute().data
        }
    }
    
    private func loadSprays() async -> NetworkError? {
        await loadSection(
            "sprays",
            into: \.sprays,
            shimmer: \.showSpraysShimmer,
            cache: caches.sprays
        ) {
            try await self.getSpraysUseCase.execute().data
                .filter { !$0.isNullSpray && $0.fullTransparentIcon != nil }
        }
    }
    
    private func loadRanks() async -> NetworkError? {
        await loadSection(
            "ranks", into: \.tiers,
            shimmer: \.showRanksShimmer,
            cache: caches.tiers
        ) {
            guard let latestEpisode = try await self.getRanksUseCase.execute().data.last else {
                throw NetworkError.emptyResponse
            }
            
            return latestEpisode.tiers.filter {
                !($0.tierName == "UNRANKED" || $0.tierName == "Unused1" || $0.tierName == "Unused2")
            }
        }
    }
    
    private func loadBuddies() async -> NetworkError? {
        await loadSection(
            "buddies",
            into: \.buddies,
            cache: caches.buddies
        ) {
            try await self.getBuddiesUseCase.execute().data
        }
    }
    
    private func loadBundles() async -> NetworkError? {
        await loadSection(
            "bundles", into: \.bundles,
            shimmer: \.showBundlesShimmer,
            cache: caches.bundles
        ) {
            try await self.getBundlesUseCase.execute().data
        }
    }
    
    private func loadAgentContracts() async -> NetworkError? {
        await loadSection(
            "contracts",
            into: \.contracts,
            shimmer: \.showContractsShimmer
        ) {
            try await self.getAgentsContractsUseCase.execute().data
        }
    }
    
    private func loadSection<Item>(
        _ name: String,
        into items: ReferenceWritableKeyPath<HomeViewModel, [Item]>,
        shimmer: ReferenceWritableKeyPath<HomeViewModel, Bool>? = nil,
        cache: (any PCacheRepository<Item>)? = nil,
        fetch: () async throws -> [Item]
    ) async -> NetworkError? {
        if let shimmer { self[keyPath: shimmer] = true }
        defer {
            if let shimmer { self[keyPath: shimmer] = false }
        }
        
        do {
            let fetched = try await fetch()
            self[keyPath: items] = fetched
            if let shimmer { self[keyPath: shimmer] = false }
            
            await saveToCache(fetched, cache: cache, name: name)
            return nil
        } catch {
            let networkError = NetworkError(error)
            if case .cancelled = networkError { return nil }
            
            print("Failed to fetch \(name) data: \(networkError.localizedDescription)")
            
            let cached = await loadFromCache(cache, name: name)
            if !cached.isEmpty {
                self[keyPath: items] = cached
                return nil
            }
            return self[keyPath: items].isEmpty ? networkError : nil
        }
    }
    
    // Save data into local cache
    private func saveToCache<Item>(
        _ items: [Item],
        cache: (any PCacheRepository<Item>)?,
        name: String
    ) async {
        guard let cache else { return }
        
        do {
            try await cache.replaceAll(with: items)
        } catch {
            print("Failed to cache \(name) data: \(error.localizedDescription)")
        }
    }
    
    // Load data from cache
    private func loadFromCache<Item>(_ cache: (any PCacheRepository<Item>)?, name: String) async -> [Item] {
        guard let cache else { return [] }
        
        do {
            return try await cache.fetchAll()
        } catch {
            print("Failed to load cached \(name) data: \(error.localizedDescription)")
            return []
        }
    }
}

extension HomeViewModel {
    func prepareShareImage(url: String) async -> Bool {
        do {
            shareImage = try await KingfisherManager.shared.downloadImage(with: url)
            return true
        } catch {
            showImageDownloadFailedAlert(error)
            return false
        }
    }
    
    func saveImageToGallary(url: String) async {
        do {
            let image = try await KingfisherManager.shared.downloadImage(with: url)
            shareImage = image
            
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
        } catch {
            showImageDownloadFailedAlert(error)
        }
    }
    
    func shareStickerOnWhatsapp(imageURL: String, completion: @escaping () -> Void) async {
        do {
            let image = try await KingfisherManager.shared.downloadImage(with: imageURL)
            shareStickerOnWhatsapp(image: image, completion: completion)
        } catch {
            print("Failed to download sticker image: \(error.localizedDescription)")
        }
    }
    
    private func showImageDownloadFailedAlert(_ error: Error) {
        guard !(error is CancellationError) else { return }
        
        print("Failed to download image: \(error.localizedDescription)")
        alertText = "Couldn't download the image. Check your connection and try again."
        showAlert = true
    }
    
    @objc
    func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if error == nil {
            alertText = "Your image has been saved to your photos."
        } else {
            alertText = "Download photos permission denied, change the photos permission to \"Add Photos only\" in settings and try again"
        }
        
        showAlert = true
    }
    
    func shareStickerOnWhatsapp(image: UIImage?, completion: @escaping () -> Void) {
        guard let image = image else { return }
        
        let outputImageTrayData = image.scaleToFit(targetSize: .init(width: 96, height: 96))
            .scaledPNGData()
        var id = StickerManager.shared.getID()
        var json: [String: Any] = [:]
        var stickersArray:[[String: Any]] = []
        var currentStickeres = StickerManager.shared.getAllStickers()
        if currentStickeres.count == 30 {
            id = id + 1
            print("increaseing id pack size has been 30 \(id)")
            StickerManager.shared.saveStickerKey(id)
            StickerManager.shared.deleteAllStickers()
            currentStickeres = []
        }
        
//        if currentStickeres.count < 3 {
//            var stickersDict = [String: Any]()
//            for sticker in currentStickeres {
//                stickersDict["image_data"] = sticker
//                stickersDict["emojis"] = ["🤣"]
//                stickersArray.append(stickersDict)
//            }
//            while( stickersArray.count != 3 ){
//                let outputPngData = image.scaleToFit(targetSize: .init(width: 512, height: 512))
//                    .scaledPNGData()
//                if let imageData = WebPEncoder().encodePNG(data: outputPngData) {
//                    stickersDict["image_data"] = imageData.base64EncodedString()
//                    StickerManager.shared.addSticker(imageData.base64EncodedString())
//                    stickersDict["emojis"] = ["🤣"]
//                    stickersArray.append(stickersDict)
//                }
//            }
//        }else {
//            var stickersDict = [String: Any]()
//            for sticker in currentStickeres {
//                stickersDict["image_data"] = sticker
//                stickersDict["emojis"] = ["🤣"]
//                stickersArray.append(stickersDict)
//            }
//            let outputPngData = image.scaleToFit(targetSize: .init(width: 512, height: 512))
//                .scaledPNGData()
//            if let imageData = WebPEncoder().encodePNG(data: outputPngData) {
//                stickersDict["image_data"] = imageData.base64EncodedString()
//                StickerManager.shared.addSticker(imageData.base64EncodedString())
//                stickersDict["emojis"] = ["🤣"]
//                stickersArray.append(stickersDict)
//            }
//        }
        
        json["identifier"] = "Valorant-Wiki\(id)"
        json["name"] = "Valorant Stickers"
        json["publisher"] = "Valorant-Wiki"
        json["tray_image"] = outputImageTrayData.base64EncodedString()
        json["stickers"] = stickersArray
        
        var jsonWithAppStoreLink: [String: Any] = json
        jsonWithAppStoreLink["ios_app_store_link"] = ""
        jsonWithAppStoreLink["android_play_store_link"] = ""
        
        guard let dataToSend = try? JSONSerialization.data(withJSONObject: jsonWithAppStoreLink, options: []) else {
            return
        }
        
        let pasteboardStickerPackDataType = "net.whatsapp.third-party.sticker-pack"
        
        let pasteboard = UIPasteboard.general
        pasteboard.setItems([[pasteboardStickerPackDataType: dataToSend]],
                            options: [
                                UIPasteboard.OptionsKey.localOnly: true,
                                UIPasteboard.OptionsKey.expirationDate: Date(timeIntervalSinceNow: 60)
                            ])
        
        
        DispatchQueue.main.async {
            if UIApplication.shared.canOpenURL(URL(string: "whatsapp://")!) {
                UIApplication.shared.open(URL(string: "whatsapp://stickerPack")!)
            }
        }
    }
}

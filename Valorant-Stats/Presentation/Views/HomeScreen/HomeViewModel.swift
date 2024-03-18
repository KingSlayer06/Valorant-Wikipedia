//
//  HomeViewModel.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 26/02/24.
//

import Foundation
import SwiftUI
import Kingfisher
import SwiftWebP
import CoreImage

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
    
    @Published var showAgentsShimmer: Bool = false
    @Published var showMapsShimmer: Bool = false
    @Published var showWeaponsShimmer: Bool = false
    @Published var showPlayerCardsShimmer: Bool = false
    @Published var showSpraysShimmer: Bool = false
    @Published var showRanksShimmer: Bool = false
    @Published var showBundlesShimmer: Bool = false
    @Published var showContractsShimmer: Bool = false
    
    private var getAgentsUseCase: PGetAgentsUseCase?
    private var getWeaponsUseCase: PGetWeaponsUseCase?
    private var getMapsUseCase: PGetMapsUseCase?
    private var getPlayerCardsUseCase: PGetPlayerCardsUseCase?
    private var getSpraysUseCase: PGetSpraysUseCase?
    private var getRanksUseCase: PGetRanksUseCase?
    private var getBuddiesUseCase: PGetBuddiesUseCase?
    private var getBundlesUseCase: PGetBundlesUseCase?
    private var getAgentsContractsUseCase: PGetAgentContractsUseCase?
    
    //CoreData Repositories
    private var agentDataRepository = AgentDataRepository()
    private var weaponDataRepository = WeaponDataRepository()
    private var mapDataRepository = MapDataRepository()
    private var playerCardDataRepository = PlayerCardDataRepository()
    private var sprayDataRepository = SprayDataRepository()
    private var tierDataRepository = TierDataRepository()
    private var buddyDataRepository = BuddyDataRepository()
    private var bundleDataRepository = BundleDataRepository()
    
    override init() {
        super.init()
        
        self.getAgentsUseCase = GetAgentsUseCase(gameAssetsRepo: GameAssetsRepository())
        self.getWeaponsUseCase = GetWeaponsUseCase(gameAssetsRepo: GameAssetsRepository())
        self.getMapsUseCase = GetMapsUseCase(gameAssetsRepo: GameAssetsRepository())
        self.getPlayerCardsUseCase = GetPlayerCardsUseCase(gameAssetsRepo: GameAssetsRepository())
        self.getSpraysUseCase = GetSpraysUseCase(gameAssetsRepo: GameAssetsRepository())
        self.getRanksUseCase = GetRanksUseCase(gameAssetsRepo: GameAssetsRepository())
        self.getBuddiesUseCase = GetBuddiesUseCase(gameAssetsRepo: GameAssetsRepository())
        self.getBundlesUseCase = GetBundlesUseCase(gameAssetsRepo: GameAssetsRepository())
        self.getAgentsContractsUseCase = GetAgentContractsUseCase(gameAssetsRepo: GameAssetsRepository())
    }
    
    func getAgents() {
        DispatchQueue.main.async {
            self.showAgentsShimmer = true
        }
        
        self.getAgentsUseCase?.execute { [weak self] result in
            switch result {
            case .success(let response):
                guard let self = self else { return }
                
                self.agents = response.data.filter { $0.isPlayableCharacter == true }
                
                DispatchQueue.main.async {
                    self.showAgentsShimmer = false
                }
                
                // Save Agents to CoreData
                self.agents.forEach { agent in
                    self.agentDataRepository.add(agent)
                }
                self.agentDataRepository.save()
                
            case .failure(let error):
                print("Failed to fetch agent data \(error.localizedDescription)")
                
                // Load Agents from CoreData
                guard let self = self else { return }
                self.agents = self.agentDataRepository.getAll()
                
                DispatchQueue.main.async {
                    self.showAgentsShimmer = false
                }
            }
        }
    }
    
    func getWeapons() {
        DispatchQueue.main.async {
            self.showWeaponsShimmer = true
        }
        
        self.getWeaponsUseCase?.execute { [weak self] result in
            switch result {
            case .success(let response):
                guard let self = self else { return }
                
                self.weapons = response.data
                
                for index in 0..<self.weapons.count {
                    self.weapons[index].skins.removeAll(where: { $0.displayName == "Random Favorite Skin" ||
                        $0.displayName.contains("Standard") })
                }
                
                DispatchQueue.main.async {
                    self.showWeaponsShimmer = false
                }
                
                // Save Weapons to CoreData
                self.weapons.forEach { weapon in
                    self.weaponDataRepository.add(weapon)
                }
                self.weaponDataRepository.save()
                
            case .failure(let error):
                print("Failed to fetch weapons data \(error.localizedDescription)")
                
                // Load Weapons from CoreData
                guard let self = self else { return }
                self.weapons = self.weaponDataRepository.getAll()
                
                DispatchQueue.main.async {
                    self.showWeaponsShimmer = false
                }
            }
        }
    }
    
    func getMaps() {
        DispatchQueue.main.async {
            self.showMapsShimmer = true
        }
        
        self.getMapsUseCase?.execute { [weak self] result in
            switch result {
            case .success(let response):
                guard let self = self else { return }
                
                self.maps = response.data.filter { !($0.displayName == "District" ||
                                                      $0.displayName == "Kasbah" ||
                                                      $0.displayName == "Drift" ||
                                                      $0.displayName == "Piazza" ||
                                                      $0.displayName == "The Range") }
                
                DispatchQueue.main.async {
                    self.showMapsShimmer = false
                }
                
                // Save Maps to CoreData
                self.maps.forEach { map in
                    self.mapDataRepository.add(map)
                }
                self.mapDataRepository.save()
                
            case .failure(let error):
                print("Failed to fetch maps data \(error.localizedDescription)")
                
                // Load Maps from CoreData
                guard let self = self else { return }
                self.maps = self.mapDataRepository.getAll()
                
                DispatchQueue.main.async {
                    self.showMapsShimmer = false
                }
            }
        }
    }
    
    func getPlayerCards() {
        DispatchQueue.main.async {
            self.showPlayerCardsShimmer = true
        }
        
        self.getPlayerCardsUseCase?.execute { [weak self] result in
            switch result {
            case .success(let response):
                guard let self = self else { return }
                
                self.playerCards = response.data
                
                DispatchQueue.main.async {
                    self.showPlayerCardsShimmer = false
                }
                
                // Save Player Cards to CoreData
                self.playerCards.forEach { playerCard in
                    self.playerCardDataRepository.add(playerCard)
                }
                self.playerCardDataRepository.save()
                
            case .failure(let error):
                print("Failed to fetch player cards data \(error.localizedDescription)")
                
                // Load Player Cards from CoreData
                guard let self = self else { return }
                self.playerCards = self.playerCardDataRepository.getAll()
                
                DispatchQueue.main.async {
                    self.showPlayerCardsShimmer = false
                }
            }
        }
    }
    
    func getSprays() {
        DispatchQueue.main.async {
            self.showSpraysShimmer = true
        }
        
        self.getSpraysUseCase?.execute { [weak self] result in
            switch result {
            case .success(let response):
                guard let self = self else { return }
                
                self.sprays = response.data.filter { !$0.isNullSpray && $0.fullTransparentIcon != nil }
                
                DispatchQueue.main.async {
                    self.showSpraysShimmer = false
                }
                
                // Save Sprays to CoreData
                self.sprays.forEach { spray in
                    self.sprayDataRepository.add(spray)
                }
                self.sprayDataRepository.save()
                
            case .failure(let error):
                print("Failed to fetch sprays data \(error.localizedDescription)")
                
                // Load Sprays from CoreData
                guard let self = self else { return }
                self.sprays = self.sprayDataRepository.getAll()
                
                DispatchQueue.main.async {
                    self.showSpraysShimmer = false
                }
            }
        }
    }
    
    func getRanks() {
        DispatchQueue.main.async {
            self.showRanksShimmer = true
        }
        
        self.getRanksUseCase?.execute { [weak self] result in
            switch result {
            case .success(let response):
                guard let self = self else { return }
                
                self.tiers = response.data.last!.tiers.filter { !($0.tierName == "UNRANKED" ||
                                                                   $0.tierName == "Unused1" ||
                                                                   $0.tierName == "Unused2") }
                
                DispatchQueue.main.async {
                    self.showRanksShimmer = false
                }
                
                // Save Ranks to CoreData
                self.tiers.forEach { tier in
                    self.tierDataRepository.add(tier)
                }
                self.tierDataRepository.save()
                
            case .failure(let error):
                print("Failed to fetch ranks data \(error.localizedDescription)")
                
                // Load Ranks from CoreData
                guard let self = self else { return }
                self.tiers = self.tierDataRepository.getAll()
                
                DispatchQueue.main.async {
                    self.showRanksShimmer = false
                }
            }
        }
    }
    
    func getBuddies() {
        self.getBuddiesUseCase?.execute { [weak self] result in
            switch result {
            case .success(let response):
                self?.buddies = response.data
                
                // Save Buddies to CoreData
                self?.buddies.forEach { buddy in
                    self?.buddyDataRepository.add(buddy)
                }
                self?.buddyDataRepository.save()
            case .failure(let error):
                print("Failed to fetch buddies data \(error.localizedDescription)")
                
                // Load Bundles from CoreData
                guard let self = self else { return }
                self.buddies = self.buddyDataRepository.getAll()
            }
        }
    }
    
    func getBundles() {
        DispatchQueue.main.async {
            self.showBundlesShimmer = true
        }
        
        self.getBundlesUseCase?.execute { [weak self] result in
            switch result {
            case .success(let response):
                guard let self = self else { return }
                
                self.bundles = response.data
                
                DispatchQueue.main.async {
                    self.showBundlesShimmer = false
                }
                
                // Save Bundles to CoreData
                self.bundles.forEach { bundle in
                    self.bundleDataRepository.add(bundle)
                }
                self.bundleDataRepository.save()
                
            case .failure(let error):
                print("Failed to fetch bundles data \(error.localizedDescription)")
                
                // Load Bundles from CoreData
                guard let self = self else { return }
                self.bundles = self.bundleDataRepository.getAll()
                
                DispatchQueue.main.async {
                    self.showBundlesShimmer = false
                }
            }
        }
    }
                                                                  
    func getAgentContracts() {
        DispatchQueue.main.async {
            self.showContractsShimmer = true
        }
        
        self.getAgentsContractsUseCase?.execute { [weak self] result in
            switch result {
            case .success(let response):
                self?.contracts = response.data
            case .failure(let error):
                print("Failed to fetch contracts data \(error.localizedDescription)")
            }
        }
    }
}

extension HomeViewModel {
    
    func downloadImage(url: String, completion: @escaping () -> Void) {
        KingfisherManager.shared.downloadImage(with: url) { image in
            guard let image = image else { return }
            
            self.shareImage = image
            completion()
        }
    }
    
    func saveImageToGallary(url: String) {
        self.downloadImage(url: url) {
            guard let image = self.shareImage else { return }
            
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
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
        
        if currentStickeres.count < 3 {
            var stickersDict = [String: Any]()
            for sticker in currentStickeres {
                stickersDict["image_data"] = sticker
                stickersDict["emojis"] = ["🤣"]
                stickersArray.append(stickersDict)
            }
            while( stickersArray.count != 3 ){
                let outputPngData = image.scaleToFit(targetSize: .init(width: 512, height: 512))
                    .scaledPNGData()
                if let imageData = WebPEncoder().encodePNG(data: outputPngData) {
                    stickersDict["image_data"] = imageData.base64EncodedString()
                    StickerManager.shared.addSticker(imageData.base64EncodedString())
                    stickersDict["emojis"] = ["🤣"]
                    stickersArray.append(stickersDict)
                }
            }
        }else {
            var stickersDict = [String: Any]()
            for sticker in currentStickeres {
                stickersDict["image_data"] = sticker
                stickersDict["emojis"] = ["🤣"]
                stickersArray.append(stickersDict)
            }
            let outputPngData = image.scaleToFit(targetSize: .init(width: 512, height: 512))
                .scaledPNGData()
            if let imageData = WebPEncoder().encodePNG(data: outputPngData) {
                stickersDict["image_data"] = imageData.base64EncodedString()
                StickerManager.shared.addSticker(imageData.base64EncodedString())
                stickersDict["emojis"] = ["🤣"]
                stickersArray.append(stickersDict)
            }
        }
        
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

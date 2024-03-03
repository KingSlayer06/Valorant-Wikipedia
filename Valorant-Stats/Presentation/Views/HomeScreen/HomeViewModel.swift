//
//  HomeViewModel.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 26/02/24.
//

import Foundation
import SwiftUI
import Kingfisher

final class HomeViewModel: NSObject, ObservableObject {
    @Published var selectedTab: SideMenuOptionsModel = .agents
    
    @Published var agents = [Agent]()
    @Published var filteredAgents = [Agent]()
    @Published var weapons = [Weapon]()
    @Published var filteredWeapons = [Weapon]()
    @Published var maps = [GameMap]()
    @Published var playerCards = [PlayerCard]()
    @Published var sprays = [Spray]()
    @Published var tiers = [Tier]()
    @Published var agentRoles = [AgentRole]()
    @Published var weaponCatagories = [String]()
    
    @Published var shareImage: UIImage?
    @Published var showAlert: Bool = false
    @Published var alertText: String = ""
    
    private var getAgentsUseCase: PGetAgentsUseCase?
    private var getWeaponsUseCase: PGetWeaponsUseCase?
    private var getMapsUseCase: PGetMapsUseCase?
    private var getPlayerCardsUseCase: PGetPlayerCardsUseCase?
    private var getSpraysUseCase: PGetSpraysUseCase?
    private var getRanksUseCase: PGetRanksUseCase?
    
    override init() {
        super.init()
        
        self.getAgentsUseCase = GetAgentsUseCase(gameAssetsRepo: GameAssetsRepository())
        self.getWeaponsUseCase = GetWeaponsUseCase(gameAssetsRepo: GameAssetsRepository())
        self.getMapsUseCase = GetMapsUseCase(gameAssetsRepo: GameAssetsRepository())
        self.getPlayerCardsUseCase = GetPlayerCardsUseCase(gameAssetsRepo: GameAssetsRepository())
        self.getSpraysUseCase = GetSpraysUseCase(gameAssetsRepo: GameAssetsRepository())
        self.getRanksUseCase = GetRanksUseCase(gameAssetsRepo: GameAssetsRepository())
    }
    
    func getAgents() {
        self.getAgentsUseCase?.execute { [weak self] result in
            switch result {
            case .success(let response):
                self?.agents = response.data.filter { $0.isPlayableCharacter == true }
                self?.filteredAgents = self?.agents ?? []
                
                guard let agents = self?.agents else { return }
                
                for agent in agents {
                    if ((self?.agentRoles.first(where: { $0.displayName == agent.role!.displayName })) != nil) {
                        continue
                    }
                    self?.agentRoles.append(agent.role!)
                }
                
            case .failure(let error):
                print("Failed to fetch agent data \(error)")
            }
        }
    }
    
    func getFilteredAgents(agentRole: AgentRole?) {
        guard let agentRole = agentRole else {
            filteredAgents = agents
            return
        }
        
        filteredAgents = agents.filter { $0.role?.displayName == agentRole.displayName }
    }
    
    func getWeapons() {
        self.getWeaponsUseCase?.execute { [weak self] result in
            switch result {
            case .success(let response):
                self?.weapons = response.data
                
                let weaponCount = self?.weapons.count ?? 0
                for index in 0..<weaponCount {
                    self?.weapons[index].skins.removeAll(where: { $0.displayName == "Random Favorite Skin" ||
                        $0.displayName.contains("Standard") })
                }
                
                self?.filteredWeapons = self?.weapons ?? []
                
                guard let weapons = self?.weapons else { return }
                
                for weapon in weapons {
                    if ((self?.weaponCatagories.first(where: { $0 == weapon.shopData?.categoryText })) != nil) {
                        continue
                    }
                    
                    if let catagory = weapon.shopData?.categoryText {
                        self?.weaponCatagories.append(catagory)
                    }
                }
                
            case .failure(let error):
                print("Failed to fetch agent data \(error)")
            }
        }
    }
    
    func getFilteredWeapons(catagory: String?) {
        guard let catagory = catagory else {
            filteredWeapons = weapons
            return
        }
        
        filteredWeapons = weapons.filter { $0.shopData?.categoryText == catagory }
    }
    
    func getMaps() {
        self.getMapsUseCase?.execute { [weak self] result in
            switch result {
            case .success(let response):
                self?.maps = response.data.filter { !($0.displayName == "District" ||
                                                      $0.displayName == "Kasbah" ||
                                                      $0.displayName == "Drift" ||
                                                      $0.displayName == "Piazza" ||
                                                      $0.displayName == "The Range") }
                
            case .failure(let error):
                print("Failed to fetch agent data \(error)")
            }
        }
    }
    
    func getPlayerCards() {
        self.getPlayerCardsUseCase?.execute { [weak self] result in
            switch result {
            case .success(let response):
                self?.playerCards = response.data
                
            case .failure(let error):
                print("Failed to fetch agent data \(error)")
            }
        }
    }
    
    func getSprays() {
        self.getSpraysUseCase?.execute { [weak self] result in
            switch result {
            case .success(let response):
                self?.sprays = response.data.filter { !$0.isNullSpray && $0.fullTransparentIcon != nil }
                
            case .failure(let error):
                print("Failed to fetch agent data \(error)")
            }
        }
    }
    
    func getRanks() {
        self.getRanksUseCase?.execute { [weak self] result in
            switch result {
            case .success(let response):
                self?.tiers = response.data.last!.tiers.filter { !($0.tierName == "UNRANKED" ||
                                                                   $0.tierName == "Unused1" ||
                                                                   $0.tierName == "Unused2") }
                
            case .failure(let error):
                print("Failed to fetch agent data \(error)")
            }
        }
    }
    
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
}

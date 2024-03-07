//
//  AppAnalytics.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 04/03/24.
//

import Foundation
import FirebaseAnalytics

class AppAnalytics {
    
    static let shared = AppAnalytics()
    
    let preferredLanguage = Locale.preferredLanguages.first
    let supportedLanguages = ["en", "pt-BR", "en-IN"]
    
    let splash = "Splash_Screen"
    let agentScreen = "Agent_Screen"
    let agentDetailsScreen = "Agent_Details_Screen"
    let mapScreen = "Map_Screen"
    let mapDetailsScreen = "Map_Details_Screen"
    let weaponScreen = "Weapon_Screen"
    let weaponDetailsScreen = "Weapon_Details_Screen"
    let weaponSkinDetailsScreen = "Weapon_Skin_Details_Screen"
    let weaponBuddyDetailsScreen = "Weapon_Buddy_Details_Screen"
    let viewAllSkinsScreen = "View_All_Skins_Screen"
    let viewAllBuddiesScreen = "View_All_Buddies_Screen"
    let playerCardScreen = "Player_Card_Screen"
    let playerCardDetailsScreen = "Player_Card_Details_Screen"
    let sprayScreen = "Spray_Screen"
    let rankScreen = "Rank_Screen"
    let patchNotesScreen = "Patch_Notes_Screen"
    let aboutScreen = "About_Screen"
    
    var language: String? {
        return self.supportedLanguages.contains(preferredLanguage ?? "en") ? preferredLanguage : "en"
    }
    
    // MARK: - Home Screen
    func QuestionMarkIconClick(screen: String) {
        Analytics.logEvent("Question_Mark_Icon_Click", parameters: [
            "Language": language ?? "en",
            "BuildEnvironment": KeyVariables.devMode.rawValue,
            "Screen": screen,
        ])
    }
    
    func BergerMenuIconClick(screen: String) {
        Analytics.logEvent("Berger_Menu_Icon_Click", parameters: [
            "Language": language ?? "en",
            "BuildEnvironment": KeyVariables.devMode.rawValue,
            "Screen": screen,
        ])
    }
    
    // MARK: - Agent Screen
    func AgentRoleClick(role: AgentRole?) {
        Analytics.logEvent("Agent_Role_Click", parameters: [
            "Language": language ?? "en",
            "BuildEnvironment": KeyVariables.devMode.rawValue,
            "Role": role?.displayName ?? "All",
            "Screen": agentScreen,
        ])
    }
    
    func AgentImageClick(agent: Agent) {
        Analytics.logEvent("Agent_Image_Click", parameters: [
            "Language": language ?? "en",
            "BuildEnvironment": KeyVariables.devMode.rawValue,
            "Agent": agent.displayName,
            "Screen": agentScreen,
        ])
    }
    
    // MARK: - Agent Detail Screen
    func AgentDetailsBackClick(agent: Agent) {
        Analytics.logEvent("Agent_Details_Back_Click", parameters: [
            "Language": language ?? "en",
            "BuildEnvironment": KeyVariables.devMode.rawValue,
            "Agent": agent.displayName,
            "Screen": agentDetailsScreen,
        ])
    }
    
    func AgentDetailsAbilityClick(ability: AgentAbilities) {
        Analytics.logEvent("Agent_Details_Ability_Click", parameters: [
            "Language": language ?? "en",
            "BuildEnvironment": KeyVariables.devMode.rawValue,
            "Ability": ability.displayName,
            "Screen": agentDetailsScreen,
        ])
    }
    
    // MARK: - Map Screen
    func MapImageClick(map: GameMap) {
        Analytics.logEvent("Map_Image_Click", parameters: [
            "Language": language ?? "en",
            "BuildEnvironment": KeyVariables.devMode.rawValue,
            "Map": map.displayName,
            "Screen": mapScreen,
        ])
    }
    
    // MARK: - Map Details Screen
    func MapDetailsBackClick(map: GameMap) {
        Analytics.logEvent("Map_Details_Back_Click", parameters: [
            "Language": language ?? "en",
            "BuildEnvironment": KeyVariables.devMode.rawValue,
            "Map": map.displayName,
            "Screen": mapDetailsScreen,
        ])
    }
    
    // MARK: - Weapon Screen
    func WeaponTypeClick(weapon: String?) {
        Analytics.logEvent("Weapon_Type_Click", parameters: [
            "Language": language ?? "en",
            "BuildEnvironment": KeyVariables.devMode.rawValue,
            "Weapon": weapon ?? "All",
            "Screen": weaponScreen,
        ])
    }
    
    func WeaponImageClick(weapon: Weapon) {
        Analytics.logEvent("Weapon_Image_Click", parameters: [
            "Language": language ?? "en",
            "BuildEnvironment": KeyVariables.devMode.rawValue,
            "Weapon": weapon.displayName,
            "Screen": weaponScreen,
        ])
    }
    
    // MARK: - Weapon Details Screen
    func WeaponDetailsBackClick(weapon: Weapon) {
        Analytics.logEvent("Weapon_Details_Back_Click", parameters: [
            "Language": language ?? "en",
            "BuildEnvironment": KeyVariables.devMode.rawValue,
            "Weapon": weapon.displayName,
            "Screen": weaponDetailsScreen,
        ])
    }
    
    func WeaponDetailsSkinClick(skin: WeaponSkin) {
        Analytics.logEvent("Weapon_Details_Skin_Click", parameters: [
            "Language": language ?? "en",
            "BuildEnvironment": KeyVariables.devMode.rawValue,
            "Skin": skin.displayName,
            "Screen": weaponDetailsScreen,
        ])
    }
    
    func WeaponDetailsBuddyClick(buddy: Buddy) {
        Analytics.logEvent("Weapon_Details_Buddy_Click", parameters: [
            "Language": language ?? "en",
            "BuildEnvironment": KeyVariables.devMode.rawValue,
            "Buddy": buddy.displayName,
            "Screen": weaponDetailsScreen,
        ])
    }
    
    // MARK: - Weapon Skin Details Screen
    func WeaponSkinDetailsBackClick(skin: WeaponSkin) {
        Analytics.logEvent("Weapon_Skin_Details_Back_Click", parameters: [
            "Language": language ?? "en",
            "BuildEnvironment": KeyVariables.devMode.rawValue,
            "Skin": skin.displayName,
            "Screen": weaponSkinDetailsScreen,
        ])
    }
    
    func WeaponSkinDetailsColorClick(color: String?) {
        guard let color = color else { return }
        
        Analytics.logEvent("Weapon_Skin_Details_Color_Click", parameters: [
            "Language": language ?? "en",
            "BuildEnvironment": KeyVariables.devMode.rawValue,
            "Color": color,
            "Screen": weaponSkinDetailsScreen,
        ])
    }
    
    func WeaponSkinDetailsLevelClick(level: String) {
        Analytics.logEvent("Weapon_Skin_Details_Level_Click", parameters: [
            "Language": language ?? "en",
            "BuildEnvironment": KeyVariables.devMode.rawValue,
            "Level": level,
            "Screen": weaponSkinDetailsScreen,
        ])
    }
    
    // MARK: - Weapon Buddy Details Screen
    func WeaponBuddyDetailsBackClick(buddy: Buddy) {
        Analytics.logEvent("Weapon_Buddy_Details_Back_Click", parameters: [
            "Language": language ?? "en",
            "BuildEnvironment": KeyVariables.devMode.rawValue,
            "Buddy": buddy.displayName,
            "Screen": weaponSkinDetailsScreen,
        ])
    }
    
    // MARK: - View All Skins Screen
    func ViewAllSkinsBackClick(weaponName: String) {
        Analytics.logEvent("View_All_Skins_Back_Click", parameters: [
            "Language": language ?? "en",
            "BuildEnvironment": KeyVariables.devMode.rawValue,
            "WeaponName": weaponName,
            "Screen": viewAllSkinsScreen,
        ])
    }
    
    func ViewAllSkinsImageClick(weaponName: String, skin: WeaponSkin) {
        Analytics.logEvent("View_All_Skins_Image_Click", parameters: [
            "Language": language ?? "en",
            "BuildEnvironment": KeyVariables.devMode.rawValue,
            "WeaponName": weaponName,
            "SkinName": skin.displayName,
            "Screen": viewAllSkinsScreen,
        ])
    }
    
    // MARK: - View All Buddies Screen
    func ViewAllBuddiesBackClick() {
        Analytics.logEvent("View_All_Buddies_Back_Click", parameters: [
            "Language": language ?? "en",
            "BuildEnvironment": KeyVariables.devMode.rawValue,
            "Screen": viewAllBuddiesScreen,
        ])
    }
    
    func ViewAllBuddiesImageClick(buddy: Buddy) {
        Analytics.logEvent("View_All_Buddies_Image_Click", parameters: [
            "Language": language ?? "en",
            "BuildEnvironment": KeyVariables.devMode.rawValue,
            "Buddy": buddy.displayName,
            "Screen": viewAllBuddiesScreen,
        ])
    }
    
    // MARK: - Player Card Screen
    func PlayerCardImageClick(card: PlayerCard) {
        Analytics.logEvent("Player_Card_Image_Click", parameters: [
            "Language": language ?? "en",
            "BuildEnvironment": KeyVariables.devMode.rawValue,
            "Card": card.displayName,
            "Screen": playerCardScreen,
        ])
    }
    
    // MARK: - Player Card Details Screen
    func PlayerCardDetailsBackClick(card: PlayerCard) {
        Analytics.logEvent("Player_Card_Details_Back_Click", parameters: [
            "Language": language ?? "en",
            "BuildEnvironment": KeyVariables.devMode.rawValue,
            "Card": card.displayName,
            "Screen": playerCardDetailsScreen,
        ])
    }
    
    func PlayerCardDetailsDownloadClick(card: PlayerCard) {
        Analytics.logEvent("Player_Card_Details_Download_Click", parameters: [
            "Language": language ?? "en",
            "BuildEnvironment": KeyVariables.devMode.rawValue,
            "Card": card.displayName,
            "Screen": playerCardDetailsScreen,
        ])
    }
    
    func PlayerCardDetailsShareClick(card: PlayerCard) {
        Analytics.logEvent("Player_Card_Details_Share_Click", parameters: [
            "Language": language ?? "en",
            "BuildEnvironment": KeyVariables.devMode.rawValue,
            "Card": card.displayName,
            "Screen": playerCardDetailsScreen,
        ])
    }
    
    // MARK: - Spray Screen
    func SprayImageClick(spray: Spray?) {
        guard let spray = spray else { return }
        
        Analytics.logEvent("Spray_Image_Click", parameters: [
            "Language": language ?? "en",
            "BuildEnvironment": KeyVariables.devMode.rawValue,
            "Card": spray.displayName,
            "Screen": sprayScreen,
        ])
    }
    
    func SprayShareOnWhatsappClick(spray: Spray?) {
        guard let spray = spray else { return }
        
        Analytics.logEvent("Spray_Share_On_Whatsapp_Click", parameters: [
            "Language": language ?? "en",
            "BuildEnvironment": KeyVariables.devMode.rawValue,
            "Card": spray.displayName,
            "Screen": sprayScreen,
        ])
    }
    
    // MARK: - Side Menu
    func SideMenuOpened(selectedTab: String) {
        Analytics.logEvent("Side_Menu_Opened_Click", parameters: [
            "Language": language ?? "en",
            "BuildEnvironment": KeyVariables.devMode.rawValue,
            "SelectedTab": selectedTab,
        ])
    }
    
    func SideMenuClosed(selectedTab: String) {
        Analytics.logEvent("Side_Menu_Closed_Click", parameters: [
            "Language": language ?? "en",
            "BuildEnvironment": KeyVariables.devMode.rawValue,
            "SelectedTab": selectedTab,
        ])
    }
    
    func SideMenuRowCick(selectedTab: String) {
        Analytics.logEvent("Side_Menu_Row_Click", parameters: [
            "Language": language ?? "en",
            "BuildEnvironment": KeyVariables.devMode.rawValue,
            "SelectedTab": selectedTab,
        ])
    }
    
    // MARK: - About Screen
    func AboutScreenBackClick() {
        Analytics.logEvent("About_Screen_Back_Click", parameters: [
            "Language": language ?? "en",
            "BuildEnvironment": KeyVariables.devMode.rawValue,
        ])
    }
    
    func AboutScreenEmailClick() {
        Analytics.logEvent("About_Screen_Email_Click", parameters: [
            "Language": language ?? "en",
            "BuildEnvironment": KeyVariables.devMode.rawValue,
        ])
    }
    
    func AboutScreenGithubClick() {
        Analytics.logEvent("About_Screen_Github_Click", parameters: [
            "Language": language ?? "en",
            "BuildEnvironment": KeyVariables.devMode.rawValue,
        ])
    }
    
    func AboutScreenLinkedInClick() {
        Analytics.logEvent("About_Screen_LinkedIn_Click", parameters: [
            "Language": language ?? "en",
            "BuildEnvironment": KeyVariables.devMode.rawValue,
        ])
    }
    
    func AboutScreenTwitterClick() {
        Analytics.logEvent("About_Screen_Twitter_Click", parameters: [
            "Language": language ?? "en",
            "BuildEnvironment": KeyVariables.devMode.rawValue,
        ])
    }
    
    // MARK: - Screen Visit
    func ScreenVisit(screen: String) {
        Analytics.logEvent("Screen_Visit", parameters: [
            "Language": language ?? "en",
            "BuildEnvironment": KeyVariables.devMode.rawValue,
            "Screen": screen,
        ])
    }
}

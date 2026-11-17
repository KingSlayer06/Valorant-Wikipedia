//
//  Destination.swift
//  Valorant-Stats
//

import Foundation

enum Destination {
    case about
    case agentDetails(Agent)
    case mapDetails(GameMap)
    case weaponDetails(Weapon)
    case weaponSkinDetails(WeaponSkin)
    case allWeaponSkins(skins: [WeaponSkin], weaponName: String)
    case allBuddies
    case buddyDetails(Buddy)
    case playerCardDetails(PlayerCard)
    case bundleDetails(WeaponBundle)
}

extension Destination: Hashable {
    private var id: String {
        switch self {
            case .about: "about"
            case .agentDetails(let agent): "agent-\(agent.uuid)"
            case .mapDetails(let map): "map-\(map.uuid)"
            case .weaponDetails(let weapon): "weapon-\(weapon.uuid)"
            case .weaponSkinDetails(let skin): "weaponSkin-\(skin.uuid)"
            case .allWeaponSkins(_, let weaponName): "allWeaponSkins-\(weaponName)"
            case .allBuddies: "allBuddies"
            case .buddyDetails(let buddy): "buddy-\(buddy.uuid)"
            case .playerCardDetails(let card): "playerCard-\(card.uuid)"
            case .bundleDetails(let bundle): "bundle-\(bundle.uuid)"
        }
    }

    static func == (lhs: Destination, rhs: Destination) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

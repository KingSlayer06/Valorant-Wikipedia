//
//  DestinationView.swift
//  Valorant-Stats
//

import SwiftUI

struct DestinationView: View {
    let destination: Destination

    var body: some View {
        switch destination {
            case .about:
                AboutView()
            case .agentDetails(let agent):
                AgentDetailsView(agent: agent)
            case .mapDetails(let map):
                MapDetailsView(map: map)
            case .weaponDetails(let weapon):
                WeaponDetailsView(weapon: weapon)
            case .weaponSkinDetails(let skin):
                WeaponSkinDetailsView(skin: skin)
            case .allWeaponSkins(let skins, let weaponName):
                ViewAllSkinsView(skins: skins, weaponName: weaponName)
            case .allBuddies:
                ViewAllBuddiesView()
            case .buddyDetails(let buddy):
                WeaponBuddyDetailView(buddy: buddy)
            case .playerCardDetails(let card):
                PlayerCardDetailsView(card: card)
            case .bundleDetails(let bundle):
                BundleDetailsView(bundle: bundle)
        }
    }
}

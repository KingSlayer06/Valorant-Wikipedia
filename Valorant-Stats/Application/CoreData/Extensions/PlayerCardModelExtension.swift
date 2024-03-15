//
//  PlayerCardModelExtension.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 15/03/24.
//

import Foundation

extension PlayerCardModel {
    
    func getPlayerCard() -> PlayerCard {
        return PlayerCard(uuid: self.uuid!,
                          displayName: self.displayName!,
                          wideArt: self.wideArt!,
                          largeArt: self.largeArt!)
    }
}

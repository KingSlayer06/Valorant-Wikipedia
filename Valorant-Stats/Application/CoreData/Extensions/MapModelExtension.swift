//
//  MapModelExtension.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 15/03/24.
//

import Foundation

extension MapModel {
    
    func getMap() -> GameMap {
        return GameMap(uuid: self.uuid!,
                       displayName: self.displayName!,
                       narrativeDescription: self.narrativeDescription,
                       coordinates: self.coordinates,
                       displayIcon: self.displayIcon,
                       listViewIcon: self.listViewIcon,
                       splash: self.splash!,
                       stylizedBackgroundImage: self.stylizedBackgroundImage)
    }
}

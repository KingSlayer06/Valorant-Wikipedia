//
//  StickerManager.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 03/03/24.
//

import Foundation
import Foundation
import Observation
import SwiftUI
import CoreImage
import UIKit
import SwiftWebP

class StickerManager {
    // UserDefaults key for storing the array of strings
    private let stickersKey = "StickersKey"
    private let id = "StickerPackID"

    static let shared = StickerManager()
    
    private init() {}
    
    // Create: Add a new sticker
    func addSticker(_ sticker: String) {
        var currentStickers = getAllStickers()
        if currentStickers.count == 30 {
            currentStickers.removeAll()
            saveStickers(currentStickers)
        }
        if !currentStickers.contains(sticker) {
            currentStickers.append(sticker)
            saveStickers(currentStickers)
        }
    }
    
    // Read: Retrieve all stickers
    func getAllStickers() -> [String] {
        return UserDefaults.standard.array(forKey: stickersKey) as? [String] ?? []
    }
    
    func deleteAllStickers() {
        var currentStickers = getAllStickers()
        currentStickers.removeAll()
        saveStickers(currentStickers)
    }
    
    // Delete: Remove a sticker at a specific index
    func deleteSticker(at index: Int) {
        var currentStickers = getAllStickers()
        
        guard index >= 0, index < currentStickers.count else {
            return // Index out of bounds
        }
        
        currentStickers.remove(at: index)
        saveStickers(currentStickers)
    }
    
    // Save stickers to UserDefaults
        private func saveStickers(_ stickers: [String]) {
            UserDefaults.standard.set(stickers, forKey: stickersKey)
        }
    
     func saveStickerKey(_ ID: Int){
         UserDefaults.standard.setValue(ID, forKey: id)
     }
    
    func getID()->Int {
        return UserDefaults.standard.integer(forKey: id)
    }
}

//
//  KeyVariables.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 26/02/24.
//

import Foundation
import SwiftUI

struct KeyVariables {
    static let devMode: DevMode = .development
    
    static var appVersion: String {
        if let buildVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            if let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String {
                
                let env = KeyVariables.devMode
                return "App Version: \(buildVersion) (\(buildNumber))"
            }
        }
        
        return ""
    }
    
    static let primaryColor: Color = Color("kPrimary")
    static let secondaryColor: Color = Color("kSecondary")
    static let primaryFont: String = "BowlbyOneSC-Regular"
    static let bottomSafeAreaInsets: CGFloat = 50
    static let sideMenuWidth = UIScreen.main.bounds.width/1.45
    
    static let apiKey = "RGAPI-204a7c22-42b5-4ea4-98d7-9a3ba09bf9d5"
    static let baseApiUrl = "https://valorant-api.com"
    
    static var showSkinDetails: Bool = false
    static var showBuddyDetails: Bool = false
}

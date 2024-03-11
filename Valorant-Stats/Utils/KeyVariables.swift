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
    
    static let baseApiUrl = "https://valorant-api.com"
    
    static var showSkinDetails: Bool = (devMode == .development)
    static var showBuddyDetails: Bool = (devMode == .development)
}

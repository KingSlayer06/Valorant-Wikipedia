//
//  AppDelegate.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 04/03/24.
//

import Foundation
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        debugPrint("CoreData Directory: \(path[0])")
        
        return true
    }
}

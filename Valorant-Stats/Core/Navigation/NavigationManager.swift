//
//  NavigationManager.swift
//  Valorant-Stats
//

import SwiftUI

@MainActor
@Observable
final class NavigationManager {
    var path = NavigationPath()

    func navigate(to destination: Destination) {
        path.append(destination)
    }

    func replaceStack(with destination: Destination) {
        path = NavigationPath()
        path.append(destination)
    }

    func popBackStack() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    func popToRoot() {
        path = NavigationPath()
    }
}

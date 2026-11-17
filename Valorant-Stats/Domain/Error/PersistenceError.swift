//
//  PersistenceError.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 17/11/26.
//

import Foundation

enum PersistenceError: Error {
    case fetchFailed(underlying: Error)
    case saveFailed(underlying: Error)
}

extension PersistenceError: LocalizedError {

    var errorDescription: String? {
        switch self {
        case .fetchFailed(let underlying):
            return "Couldn't read saved data: \(underlying.localizedDescription)"
        case .saveFailed(let underlying):
            return "Couldn't save data for offline use: \(underlying.localizedDescription)"
        }
    }
}

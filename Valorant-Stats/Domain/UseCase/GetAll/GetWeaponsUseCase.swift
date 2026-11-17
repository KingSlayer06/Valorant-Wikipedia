//
//  GetWeaponsUseCase.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 26/02/24.
//

import Foundation

protocol PGetWeaponsUseCase {
    func execute() async throws -> GetWeaponsResponse
}

final class GetWeaponsUseCase: PGetWeaponsUseCase {
    
    private let gameAssetsRepo: PGameAssetsRepository
    
    init(gameAssetsRepo: PGameAssetsRepository) {
        self.gameAssetsRepo = gameAssetsRepo
    }
    
    func execute() async throws -> GetWeaponsResponse {
        try await gameAssetsRepo.getWeapons()
    }
}

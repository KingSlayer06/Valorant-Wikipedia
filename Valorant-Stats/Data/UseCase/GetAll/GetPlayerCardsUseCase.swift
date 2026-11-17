//
//  GetPlayerCardUseCase.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 27/02/24.
//

import Foundation

protocol PGetPlayerCardsUseCase {
    func execute() async throws -> GetPlayerCardsResponse
}

final class GetPlayerCardsUseCase: PGetPlayerCardsUseCase {
    
    private let gameAssetsRepo: PGameAssetsRepository
    
    init(gameAssetsRepo: PGameAssetsRepository) {
        self.gameAssetsRepo = gameAssetsRepo
    }
    
    func execute() async throws -> GetPlayerCardsResponse {
        try await gameAssetsRepo.getPlayerCards()
    }
}

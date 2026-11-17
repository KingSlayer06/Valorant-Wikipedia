//
//  GetValorantUseCase.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 26/02/24.
//

import Foundation

protocol PGetAgentsUseCase {
    func execute() async throws -> GetAgentsResponse
}

final class GetAgentsUseCase: PGetAgentsUseCase {
    
    private let gameAssetsRepo: PGameAssetsRepository
    
    init(gameAssetsRepo: PGameAssetsRepository) {
        self.gameAssetsRepo = gameAssetsRepo
    }
    
    func execute() async throws -> GetAgentsResponse {
        try await gameAssetsRepo.getAgents()
    }
}

//
//  GetAgentContractsUseCase.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 13/03/24.
//

import Foundation

protocol PGetAgentContractsUseCase {
    func execute() async throws -> GetAgentContractsResponse
}

final class GetAgentContractsUseCase: PGetAgentContractsUseCase {
    
    private let gameAssetsRepo: PGameAssetsRepository
    
    init(gameAssetsRepo: PGameAssetsRepository) {
        self.gameAssetsRepo = gameAssetsRepo
    }
    
    func execute() async throws -> GetAgentContractsResponse {
        try await gameAssetsRepo.getAgentContracts()
    }
}

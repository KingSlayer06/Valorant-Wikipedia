//
//  GetRanksUseCase.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 03/03/24.
//

import Foundation

protocol PGetRanksUseCase {
    func execute() async throws -> GetRanksResponse
}

final class GetRanksUseCase: PGetRanksUseCase {
    
    private let gameAssetsRepo: PGameAssetsRepository
    
    init(gameAssetsRepo: PGameAssetsRepository) {
        self.gameAssetsRepo = gameAssetsRepo
    }
    
    func execute() async throws -> GetRanksResponse {
        try await gameAssetsRepo.getRanks()
    }
}

//
//  GetSpraysUseCase.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 27/02/24.
//

import Foundation

protocol PGetSpraysUseCase {
    func execute() async throws -> GetSpraysResponse
}

final class GetSpraysUseCase: PGetSpraysUseCase {
    
    private let gameAssetsRepo: PGameAssetsRepository
    
    init(gameAssetsRepo: PGameAssetsRepository) {
        self.gameAssetsRepo = gameAssetsRepo
    }
    
    func execute() async throws -> GetSpraysResponse {
        try await gameAssetsRepo.getSprays()
    }
}

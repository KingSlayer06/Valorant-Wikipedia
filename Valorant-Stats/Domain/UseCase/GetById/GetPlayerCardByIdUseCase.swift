//
//  GetPlayerCardByIdUseCase.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 13/03/24.
//

import Foundation

protocol PGetPlayerCardByIdUseCase {
    func execute(uuid: String) async throws -> GetPlayerCardByIdResponse
}

final class GetPlayerCardByIdUseCase: PGetPlayerCardByIdUseCase {
    
    private let gameAssetsRepo: PGameAssetsRepository
    
    init(gameAssetsRepo: PGameAssetsRepository) {
        self.gameAssetsRepo = gameAssetsRepo
    }
    
    func execute(uuid: String) async throws -> GetPlayerCardByIdResponse {
        try await gameAssetsRepo.getPlayerCardById(uuid: uuid)
    }
}

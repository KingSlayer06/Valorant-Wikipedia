//
//  GetTitleByIdUseCase.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 13/03/24.
//

import Foundation

protocol PGetPlayerTitleByIdUseCase {
    func execute(uuid: String) async throws -> GetPlayerTitleByIdResponse
}

final class GetPlayerTitleByIdUseCase: PGetPlayerTitleByIdUseCase {
    
    private let gameAssetsRepo: PGameAssetsRepository
    
    init(gameAssetsRepo: PGameAssetsRepository) {
        self.gameAssetsRepo = gameAssetsRepo
    }
    
    func execute(uuid: String) async throws -> GetPlayerTitleByIdResponse {
        try await gameAssetsRepo.getPlayerTitleById(uuid: uuid)
    }
}

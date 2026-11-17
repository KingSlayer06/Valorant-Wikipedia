//
//  GetSprayByIdUseCase.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 13/03/24.
//

import Foundation

protocol PGetSprayByIdUseCase {
    func execute(uuid: String) async throws -> GetSprayByIdResponse
}

final class GetSprayByIdUseCase: PGetSprayByIdUseCase {
    
    private let gameAssetsRepo: PGameAssetsRepository
    
    init(gameAssetsRepo: PGameAssetsRepository) {
        self.gameAssetsRepo = gameAssetsRepo
    }
    
    func execute(uuid: String) async throws -> GetSprayByIdResponse {
        try await gameAssetsRepo.getSprayById(uuid: uuid)
    }
}

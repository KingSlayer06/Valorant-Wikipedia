//
//  GetCurrencyByIdUseCase.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 13/03/24.
//

import Foundation

protocol PGetCurrencyByIdUseCase {
    func execute(uuid: String) async throws -> GetCurrencyByIdResponse
}

final class GetCurrencyByIdUseCase: PGetCurrencyByIdUseCase {
    
    private let gameAssetsRepo: PGameAssetsRepository
    
    init(gameAssetsRepo: PGameAssetsRepository) {
        self.gameAssetsRepo = gameAssetsRepo
    }
    
    func execute(uuid: String) async throws -> GetCurrencyByIdResponse {
        try await gameAssetsRepo.getCurrencyById(uuid: uuid)
    }
}

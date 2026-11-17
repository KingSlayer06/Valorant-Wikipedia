//
//  GetMapsUseCase.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 26/02/24.
//

import Foundation

protocol PGetMapsUseCase {
    func execute() async throws -> GetMapsResponse
}

final class GetMapsUseCase: PGetMapsUseCase {
    
    private let gameAssetsRepo: PGameAssetsRepository
    
    init(gameAssetsRepo: PGameAssetsRepository) {
        self.gameAssetsRepo = gameAssetsRepo
    }
    
    func execute() async throws -> GetMapsResponse {
        try await gameAssetsRepo.getMaps()
    }
}

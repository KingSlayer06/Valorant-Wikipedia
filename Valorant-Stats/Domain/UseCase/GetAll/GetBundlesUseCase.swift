//
//  GetBundlesUseCase.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 07/03/24.
//

import Foundation

protocol PGetBundlesUseCase {
    func execute() async throws -> GetBundlesResponse
}

final class GetBundlesUseCase: PGetBundlesUseCase {
    
    private let gameAssetsRepo: PGameAssetsRepository
    
    init(gameAssetsRepo: PGameAssetsRepository) {
        self.gameAssetsRepo = gameAssetsRepo
    }
    
    func execute() async throws -> GetBundlesResponse {
        try await gameAssetsRepo.getBundles()
    }
}

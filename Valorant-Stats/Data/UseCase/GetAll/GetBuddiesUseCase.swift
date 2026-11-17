//
//  GetBuddies.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 07/03/24.
//

import Foundation

protocol PGetBuddiesUseCase {
    func execute() async throws -> GetBuddiesResponse
}

final class GetBuddiesUseCase: PGetBuddiesUseCase {
    
    private let gameAssetsRepo: PGameAssetsRepository
    
    init(gameAssetsRepo: PGameAssetsRepository) {
        self.gameAssetsRepo = gameAssetsRepo
    }
    
    func execute() async throws -> GetBuddiesResponse {
        try await gameAssetsRepo.getBuddies()
    }
}

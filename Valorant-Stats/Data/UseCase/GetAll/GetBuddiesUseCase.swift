//
//  GetBuddies.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 07/03/24.
//

import Foundation
import Alamofire

protocol PGetBuddiesUseCase {
    func execute(completion: @escaping (Result<GetBuddiesResponse, AFError>) -> Void)
}

final class GetBuddiesUseCase: PGetBuddiesUseCase {
    
    private var gameAssetsRepo: GameAssetsRepository
    
    init(gameAssetsRepo: GameAssetsRepository) {
        self.gameAssetsRepo = gameAssetsRepo
    }
    
    func execute(completion: @escaping (Result<GetBuddiesResponse, AFError>) -> Void) {
        gameAssetsRepo.getBuddies { result in
            completion(result)
        }
    }
}

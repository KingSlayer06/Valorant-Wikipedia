//
//  GetPlayerCardUseCase.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 27/02/24.
//

import Foundation
import Alamofire

protocol PGetPlayerCardsUseCase {
    func execute(completion: @escaping (Result<GetPlayerCardsResponse, AFError>) -> Void)
}

final class GetPlayerCardsUseCase: PGetPlayerCardsUseCase {
    
    private var gameAssetsRepo: GameAssetsRepository
    
    init(gameAssetsRepo: GameAssetsRepository) {
        self.gameAssetsRepo = gameAssetsRepo
    }
    
    func execute(completion: @escaping (Result<GetPlayerCardsResponse, AFError>) -> Void) {
        gameAssetsRepo.getPlayerCards { result in
            completion(result)
        }
    }
}

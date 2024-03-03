//
//  GetValorantUseCase.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 26/02/24.
//

import Foundation
import Alamofire

protocol PGetAgentsUseCase {
    func execute(completion: @escaping (Result<GetAgentsResponse, AFError>) -> Void)
}

final class GetAgentsUseCase: PGetAgentsUseCase {
    
    private var gameAssetsRepo: GameAssetsRepository
    
    init(gameAssetsRepo: GameAssetsRepository) {
        self.gameAssetsRepo = gameAssetsRepo
    }
    
    func execute(completion: @escaping (Result<GetAgentsResponse, AFError>) -> Void) {
        gameAssetsRepo.getAgents { result in
            completion(result)
        }
    }
}

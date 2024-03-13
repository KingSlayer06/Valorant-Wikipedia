//
//  GetAgentContractsUseCase.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 13/03/24.
//

import Foundation
import Alamofire

protocol PGetAgentContractsUseCase {
    func execute(completion: @escaping (Result<GetAgentContractsResponse, AFError>) -> Void)
}

final class GetAgentContractsUseCase: PGetAgentContractsUseCase {
    
    private var gameAssetsRepo: GameAssetsRepository
    
    init(gameAssetsRepo: GameAssetsRepository) {
        self.gameAssetsRepo = gameAssetsRepo
    }
    
    func execute(completion: @escaping (Result<GetAgentContractsResponse, AFError>) -> Void) {
        gameAssetsRepo.getAgentContracts { result in
            completion(result)
        }
    }
}

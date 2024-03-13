//
//  GetRanksUseCase.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 03/03/24.
//

import Foundation
import Alamofire

protocol PGetRanksUseCase {
    func execute(completion: @escaping (Result<GetRanksResponse, AFError>) -> Void)
}

final class GetRanksUseCase: PGetRanksUseCase {
    
    private var gameAssetsRepo: GameAssetsRepository
    
    init(gameAssetsRepo: GameAssetsRepository) {
        self.gameAssetsRepo = gameAssetsRepo
    }
    
    func execute(completion: @escaping (Result<GetRanksResponse, AFError>) -> Void) {
        gameAssetsRepo.getRanks { result in
            completion(result)
        }
    }
}

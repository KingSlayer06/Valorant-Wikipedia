//
//  GetSpraysUseCase.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 27/02/24.
//

import Foundation
import Alamofire

protocol PGetSpraysUseCase {
    func execute(completion: @escaping (Result<GetSpraysResponse, AFError>) -> Void)
}

final class GetSpraysUseCase: PGetSpraysUseCase {
    
    private var gameAssetsRepo: GameAssetsRepository
    
    init(gameAssetsRepo: GameAssetsRepository) {
        self.gameAssetsRepo = gameAssetsRepo
    }
    
    func execute(completion: @escaping (Result<GetSpraysResponse, AFError>) -> Void) {
        gameAssetsRepo.getSprays { result in
            completion(result)
        }
    }
}

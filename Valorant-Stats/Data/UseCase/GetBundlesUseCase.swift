//
//  GetBundlesUseCase.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 07/03/24.
//

import Foundation
import Alamofire

protocol PGetBundlesUseCase {
    func execute(completion: @escaping (Result<GetBundlesResponse, AFError>) -> Void)
}

final class GetBundlesUseCase: PGetBundlesUseCase {
    
    private var gameAssetsRepo: GameAssetsRepository
    
    init(gameAssetsRepo: GameAssetsRepository) {
        self.gameAssetsRepo = gameAssetsRepo
    }
    
    func execute(completion: @escaping (Result<GetBundlesResponse, AFError>) -> Void) {
        gameAssetsRepo.getBundles { result in
            completion(result)
        }
    }
}

//
//  GetMapsUseCase.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 26/02/24.
//

import Foundation
import Alamofire

protocol PGetMapsUseCase {
    func execute(completion: @escaping (Result<GetMapsResponse, AFError>) -> Void)
}

final class GetMapsUseCase: PGetMapsUseCase {
    
    private var gameAssetsRepo: GameAssetsRepository
    
    init(gameAssetsRepo: GameAssetsRepository) {
        self.gameAssetsRepo = gameAssetsRepo
    }
    
    func execute(completion: @escaping (Result<GetMapsResponse, AFError>) -> Void) {
        gameAssetsRepo.getMaps { result in
            completion(result)
        }
    }
}

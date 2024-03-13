//
//  GetCurrencyByIdUseCase.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 13/03/24.
//

import Foundation
import Alamofire

protocol PGetCurrencyByIdUseCase {
    func execute(uuid: String, completion: @escaping (Result<GetCurrencyByIdResponse, AFError>) -> Void)
}

final class GetCurrencyByIdUseCase: PGetCurrencyByIdUseCase {
    
    private var gameAssetsRepo: GameAssetsRepository
    
    init(gameAssetsRepo: GameAssetsRepository) {
        self.gameAssetsRepo = gameAssetsRepo
    }
    
    func execute(uuid: String, completion: @escaping (Result<GetCurrencyByIdResponse, AFError>) -> Void) {
        gameAssetsRepo.getCurrencyById(uuid: uuid) { result in
            completion(result)
        }
    }
}

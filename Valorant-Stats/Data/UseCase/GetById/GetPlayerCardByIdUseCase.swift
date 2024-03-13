//
//  GetPlayerCardByIdUseCase.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 13/03/24.
//

import Foundation
import Alamofire

protocol PGetPlayerCardByIdUseCase {
    func execute(uuid: String, completion: @escaping (Result<GetPlayerCardByIdResponse, AFError>) -> Void)
}

final class GetPlayerCardByIdUseCase: PGetPlayerCardByIdUseCase {
    
    private var gameAssetsRepo: GameAssetsRepository
    
    init(gameAssetsRepo: GameAssetsRepository) {
        self.gameAssetsRepo = gameAssetsRepo
    }
    
    func execute(uuid: String, completion: @escaping (Result<GetPlayerCardByIdResponse, AFError>) -> Void) {
        gameAssetsRepo.getPlayerCardById(uuid: uuid) { result in
            completion(result)
        }
    }
}

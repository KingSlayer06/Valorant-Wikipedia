//
//  GetSprayByIdUseCase.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 13/03/24.
//

import Foundation
import Alamofire

protocol PGetSprayByIdUseCase {
    func execute(uuid: String, completion: @escaping (Result<GetSprayByIdResponse, AFError>) -> Void)
}

final class GetSprayByIdUseCase: PGetSprayByIdUseCase {
    
    private var gameAssetsRepo: GameAssetsRepository
    
    init(gameAssetsRepo: GameAssetsRepository) {
        self.gameAssetsRepo = gameAssetsRepo
    }
    
    func execute(uuid: String, completion: @escaping (Result<GetSprayByIdResponse, AFError>) -> Void) {
        gameAssetsRepo.getSprayById(uuid: uuid) { result in
            completion(result)
        }
    }
}

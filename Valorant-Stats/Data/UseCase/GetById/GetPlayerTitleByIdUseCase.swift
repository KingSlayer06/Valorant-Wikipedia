//
//  GetTitleByIdUseCase.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 13/03/24.
//

import Foundation
import Alamofire

protocol PGetPlayerTitleByIdUseCase {
    func execute(uuid: String, completion: @escaping (Result<GetPlayerTitleByIdResponse, AFError>) -> Void)
}

final class GetPlayerTitleByIdUseCase: PGetPlayerTitleByIdUseCase {
    
    private var gameAssetsRepo: GameAssetsRepository
    
    init(gameAssetsRepo: GameAssetsRepository) {
        self.gameAssetsRepo = gameAssetsRepo
    }
    
    func execute(uuid: String, completion: @escaping (Result<GetPlayerTitleByIdResponse, AFError>) -> Void) {
        gameAssetsRepo.getPlayerTitleById(uuid: uuid) { result in
            completion(result)
        }
    }
}

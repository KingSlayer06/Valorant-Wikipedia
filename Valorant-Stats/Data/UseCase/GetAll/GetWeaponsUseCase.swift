//
//  GetWeaponsUseCase.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 26/02/24.
//

import Foundation

import Alamofire

protocol PGetWeaponsUseCase {
    func execute(completion: @escaping (Result<GetWeaponsResponse, AFError>) -> Void)
}

final class GetWeaponsUseCase: PGetWeaponsUseCase {
    
    private var gameAssetsRepo: GameAssetsRepository
    
    init(gameAssetsRepo: GameAssetsRepository) {
        self.gameAssetsRepo = gameAssetsRepo
    }
    
    func execute(completion: @escaping (Result<GetWeaponsResponse, AFError>) -> Void) {
        gameAssetsRepo.getWeapons { result in
            completion(result)
        }
    }
}

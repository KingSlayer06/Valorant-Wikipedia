//
//  AgentContractsViewModel.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 13/03/24.
//

import Foundation

final class AgentContractsViewModel: ObservableObject {
    
    private let getSprayByIdUseCase: PGetSprayByIdUseCase?
    private let getPlayerCardByIdUseCase: PGetPlayerCardByIdUseCase?
    private let getPlayerTitleByIdUseCase: PGetPlayerTitleByIdUseCase?
    private let getCurrencyByIdUseCase: PGetCurrencyByIdUseCase?
    
    init() {
        self.getSprayByIdUseCase = GetSprayByIdUseCase(gameAssetsRepo: GameAssetsRepository())
        self.getPlayerCardByIdUseCase = GetPlayerCardByIdUseCase(gameAssetsRepo: GameAssetsRepository())
        self.getPlayerTitleByIdUseCase = GetPlayerTitleByIdUseCase(gameAssetsRepo: GameAssetsRepository())
        self.getCurrencyByIdUseCase = GetCurrencyByIdUseCase(gameAssetsRepo: GameAssetsRepository())
    }
    
    func getSpray(uuid: String, completion: @escaping (Spray) -> Void) {
        self.getSprayByIdUseCase?.execute(uuid: uuid) { result in
            switch result {
                case .success(let response):
                    completion(response.data)
                case .failure(let error):
                    print("Failed to fetch spray data \(error)")
            }
        }
    }
    
    func getPlayerCard(uuid: String, completion: @escaping (PlayerCard) -> Void) {
        self.getPlayerCardByIdUseCase?.execute(uuid: uuid) { result in
            switch result {
                case .success(let response):
                    completion(response.data)
                case .failure(let error):
                    print("Failed to fetch player card data \(error)")
            }
        }
    }
    
    func getPlayerTitle(uuid: String, completion: @escaping (PlayerTitle) -> Void) {
        self.getPlayerTitleByIdUseCase?.execute(uuid: uuid) { result in
            switch result {
                case .success(let response):
                    completion(response.data)
                case .failure(let error):
                    print("Failed to fetch player title data \(error)")
            }
        }
    }
    
    func getCurrency(uuid: String, completion: @escaping (GameCurrency) -> Void) {
        self.getCurrencyByIdUseCase?.execute(uuid: uuid) { result in
            switch result {
                case .success(let response):
                    completion(response.data)
                case .failure(let error):
                    print("Failed to fetch currency data \(error)")
            }
        }
    }
}

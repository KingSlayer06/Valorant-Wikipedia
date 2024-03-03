//
//  ContentRepository.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 26/02/24.
//

import Foundation
import Alamofire
import Combine

protocol PGameAssetsRepository {
    func getAgents(completion: @escaping (Result<GetAgentsResponse, AFError>) -> Void)
    func getWeapons(completion: @escaping (Result<GetWeaponsResponse, AFError>) -> Void)
    func getMaps(completion: @escaping (Result<GetMapsResponse, AFError>) -> Void)
    func getPlayerCards(completion: @escaping (Result<GetPlayerCardsResponse, AFError>) -> Void)
    func getSprays(completion: @escaping (Result<GetSpraysResponse, AFError>) -> Void)
    func getRanks(completion: @escaping (Result<GetRanksResponse, AFError>) -> Void)
}

final class GameAssetsRepository: PGameAssetsRepository {
    
    private var cancellables = Set<AnyCancellable>()
    
    func getAgents(completion: @escaping (Result<GetAgentsResponse, AFError>) -> Void) {
        print("getAgents API called")
        
        AF.request("\(KeyVariables.baseApiUrl)/v1/agents", method: .get, parameters: nil)
            .publishDecodable(type: GetAgentsResponse.self)
            .sink(receiveValue: { response in
                completion(response.result)
            })
            .store(in: &cancellables)
    }
    
    func getWeapons(completion: @escaping (Result<GetWeaponsResponse, AFError>) -> Void) {
        print("getWeapons API called")
        
        AF.request("\(KeyVariables.baseApiUrl)/v1/weapons", method: .get, parameters: nil)
            .publishDecodable(type: GetWeaponsResponse.self)
            .sink(receiveValue: { response in
                completion(response.result)
            })
            .store(in: &cancellables)
    }
    
    func getMaps(completion: @escaping (Result<GetMapsResponse, AFError>) -> Void) {
        print("getMaps API called")
        
        AF.request("\(KeyVariables.baseApiUrl)/v1/maps", method: .get, parameters: nil)
            .publishDecodable(type: GetMapsResponse.self)
            .sink(receiveValue: { response in
                completion(response.result)
            })
            .store(in: &cancellables)
    }
    
    func getPlayerCards(completion: @escaping (Result<GetPlayerCardsResponse, AFError>) -> Void) {
        print("getPlayerCards API called")
        
        AF.request("\(KeyVariables.baseApiUrl)/v1/playercards", method: .get, parameters: nil)
            .publishDecodable(type: GetPlayerCardsResponse.self)
            .sink(receiveValue: { response in
                completion(response.result)
            })
            .store(in: &cancellables)
    }
    
    func getSprays(completion: @escaping (Result<GetSpraysResponse, AFError>) -> Void) {
        print("getSprays API called")
        
        AF.request("\(KeyVariables.baseApiUrl)/v1/sprays", method: .get, parameters: nil)
            .publishDecodable(type: GetSpraysResponse.self)
            .sink(receiveValue: { response in
                completion(response.result)
            })
            .store(in: &cancellables)
    }
    
    func getRanks(completion: @escaping (Result<GetRanksResponse, AFError>) -> Void) {
        print("getRanks API called")
        
        AF.request("\(KeyVariables.baseApiUrl)/v1/competitivetiers", method: .get, parameters: nil)
            .publishDecodable(type: GetRanksResponse.self)
            .sink(receiveValue: { response in
                completion(response.result)
            })
            .store(in: &cancellables)
    }
}

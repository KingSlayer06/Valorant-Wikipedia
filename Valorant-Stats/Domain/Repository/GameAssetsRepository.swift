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
    func getBuddies(completion: @escaping (Result<GetBuddiesResponse, AFError>) -> Void)
    
    func getSprayById(uuid: String, completion: @escaping (Result<GetSprayByIdResponse, AFError>) -> Void)
    func getPlayerCardById(uuid: String, completion: @escaping (Result<GetPlayerCardByIdResponse, AFError>) -> Void)
    func getPlayerTitleById(uuid: String, completion: @escaping (Result<GetPlayerTitleByIdResponse, AFError>) -> Void)
    func getCurrencyById(uuid: String, completion: @escaping (Result<GetCurrencyByIdResponse, AFError>) -> Void)
}

final class GameAssetsRepository: PGameAssetsRepository {
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Fetch All
    
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
    
    func getBuddies(completion: @escaping (Result<GetBuddiesResponse, AFError>) -> Void) {
        print("getBuddies API called")
        
        AF.request("\(KeyVariables.baseApiUrl)/v1/buddies", method: .get, parameters: nil)
            .publishDecodable(type: GetBuddiesResponse.self)
            .sink(receiveValue: { response in
                completion(response.result)
            })
            .store(in: &cancellables)
    }
    
    func getBundles(completion: @escaping (Result<GetBundlesResponse, AFError>) -> Void) {
        print("getBundles API called")
        
        AF.request("\(KeyVariables.baseApiUrl)/v1/bundles", method: .get, parameters: nil)
            .publishDecodable(type: GetBundlesResponse.self)
            .sink(receiveValue: { response in
                completion(response.result)
            })
            .store(in: &cancellables)
    }
    
    func getAgentContracts(completion: @escaping (Result<GetAgentContractsResponse, AFError>) -> Void) {
        print("getAgentContracts API called")
        
        AF.request("\(KeyVariables.baseApiUrl)/v1/contracts", method: .get, parameters: nil)
            .publishDecodable(type: GetAgentContractsResponse.self)
            .sink(receiveValue: { response in
                completion(response.result)
            })
            .store(in: &cancellables)
    }
    
    // MARK: - Fetch By UUID
    
    func getSprayById(uuid: String, completion: @escaping (Result<GetSprayByIdResponse, AFError>) -> Void) {
        print("getSprayById API called")
        
        AF.request("\(KeyVariables.baseApiUrl)/v1/sprays/\(uuid)", method: .get, parameters: nil)
            .publishDecodable(type: GetSprayByIdResponse.self)
            .sink(receiveValue: { response in
                completion(response.result)
            })
            .store(in: &cancellables)
    }
    
    func getPlayerCardById(uuid: String, completion: @escaping (Result<GetPlayerCardByIdResponse, AFError>) -> Void) {
        print("getPlayerCardById API called")
        
        AF.request("\(KeyVariables.baseApiUrl)/v1/playercards/\(uuid)", method: .get, parameters: nil)
            .publishDecodable(type: GetPlayerCardByIdResponse.self)
            .sink(receiveValue: { response in
                completion(response.result)
            })
            .store(in: &cancellables)
    }
    
    func getPlayerTitleById(uuid: String, completion: @escaping (Result<GetPlayerTitleByIdResponse, AFError>) -> Void) {
        print("getPlayerTitleById API called")
        
        AF.request("\(KeyVariables.baseApiUrl)/v1/playertitles/\(uuid)", method: .get, parameters: nil)
            .publishDecodable(type: GetPlayerTitleByIdResponse.self)
            .sink(receiveValue: { response in
                completion(response.result)
            })
            .store(in: &cancellables)
    }
    
    func getCurrencyById(uuid: String, completion: @escaping (Result<GetCurrencyByIdResponse, AFError>) -> Void) {
        print("getCurrencyById API called")
        
        AF.request("\(KeyVariables.baseApiUrl)/v1/currencies/\(uuid)", method: .get, parameters: nil)
            .publishDecodable(type: GetCurrencyByIdResponse.self)
            .sink(receiveValue: { response in
                completion(response.result)
            })
            .store(in: &cancellables)
    }
}

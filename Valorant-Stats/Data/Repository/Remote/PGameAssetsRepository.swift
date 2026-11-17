//
//  PGameAssetsRepository.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 17/11/26.
//

import Foundation

protocol PGameAssetsRepository {
    func getAgents() async throws -> GetAgentsResponse
    func getWeapons() async throws -> GetWeaponsResponse
    func getMaps() async throws -> GetMapsResponse
    func getPlayerCards() async throws -> GetPlayerCardsResponse
    func getSprays() async throws -> GetSpraysResponse
    func getRanks() async throws -> GetRanksResponse
    func getBuddies() async throws -> GetBuddiesResponse
    func getBundles() async throws -> GetBundlesResponse
    func getAgentContracts() async throws -> GetAgentContractsResponse

    func getSprayById(uuid: String) async throws -> GetSprayByIdResponse
    func getPlayerCardById(uuid: String) async throws -> GetPlayerCardByIdResponse
    func getPlayerTitleById(uuid: String) async throws -> GetPlayerTitleByIdResponse
    func getCurrencyById(uuid: String) async throws -> GetCurrencyByIdResponse
}

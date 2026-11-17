//
//  GameAssetsRepository.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 26/02/24.
//

import Foundation
import Alamofire

final class GameAssetsRepository: PGameAssetsRepository {

    private let session: Session

    init(session: Session = .default) {
        self.session = session
    }

    // MARK: - Fetch All

    func getAgents() async throws -> GetAgentsResponse {
        try await request("/v1/agents", parameters: ["isPlayableCharacter": "true"])
    }

    func getWeapons() async throws -> GetWeaponsResponse {
        try await request("/v1/weapons")
    }

    func getMaps() async throws -> GetMapsResponse {
        try await request("/v1/maps")
    }

    func getPlayerCards() async throws -> GetPlayerCardsResponse {
        try await request("/v1/playercards")
    }

    func getSprays() async throws -> GetSpraysResponse {
        try await request("/v1/sprays")
    }

    func getRanks() async throws -> GetRanksResponse {
        try await request("/v1/competitivetiers")
    }

    func getBuddies() async throws -> GetBuddiesResponse {
        try await request("/v1/buddies")
    }

    func getBundles() async throws -> GetBundlesResponse {
        try await request("/v1/bundles")
    }

    func getAgentContracts() async throws -> GetAgentContractsResponse {
        try await request("/v1/contracts")
    }

    // MARK: - Fetch By UUID

    func getSprayById(uuid: String) async throws -> GetSprayByIdResponse {
        try await request("/v1/sprays/\(uuid)")
    }

    func getPlayerCardById(uuid: String) async throws -> GetPlayerCardByIdResponse {
        try await request("/v1/playercards/\(uuid)")
    }

    func getPlayerTitleById(uuid: String) async throws -> GetPlayerTitleByIdResponse {
        try await request("/v1/playertitles/\(uuid)")
    }

    func getCurrencyById(uuid: String) async throws -> GetCurrencyByIdResponse {
        try await request("/v1/currencies/\(uuid)")
    }

    // MARK: - Request
    private func request<Response: Decodable>(
        _ path: String,
        parameters: [String: String]? = nil
    ) async throws -> Response {
        print("\(path) API called")

        do {
            try Task.checkCancellation()

            return try await session.request(
                "\(KeyVariables.baseApiUrl)\(path)",
                method: .get,
                parameters: parameters,
                encoder: URLEncodedFormParameterEncoder.default
            )
            .validate()
            .serializingDecodable(Response.self, automaticallyCancelling: true)
            .value
        } catch {
            throw NetworkError(error)
        }
    }
}

//
//  AgentContractsViewModel.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 13/03/24.
//

import Foundation

@MainActor
@Observable
final class AgentContractsViewModel {
    var error: NetworkError?

    @ObservationIgnored
    var isShowingError: Bool {
        get { error != nil }
        set { if !newValue { error = nil } }
    }

    private let getSprayByIdUseCase: PGetSprayByIdUseCase
    private let getPlayerCardByIdUseCase: PGetPlayerCardByIdUseCase
    private let getPlayerTitleByIdUseCase: PGetPlayerTitleByIdUseCase
    private let getCurrencyByIdUseCase: PGetCurrencyByIdUseCase

    init(gameAssetsRepo: PGameAssetsRepository = GameAssetsRepository()) {
        self.getSprayByIdUseCase = GetSprayByIdUseCase(gameAssetsRepo: gameAssetsRepo)
        self.getPlayerCardByIdUseCase = GetPlayerCardByIdUseCase(gameAssetsRepo: gameAssetsRepo)
        self.getPlayerTitleByIdUseCase = GetPlayerTitleByIdUseCase(gameAssetsRepo: gameAssetsRepo)
        self.getCurrencyByIdUseCase = GetCurrencyByIdUseCase(gameAssetsRepo: gameAssetsRepo)
    }

    func getSpray(uuid: String) async -> Spray? {
        await perform("spray") {
            try await self.getSprayByIdUseCase.execute(uuid: uuid).data
        }
    }

    func getPlayerCard(uuid: String) async -> PlayerCard? {
        await perform("player card") {
            try await self.getPlayerCardByIdUseCase.execute(uuid: uuid).data
        }
    }

    func getPlayerTitle(uuid: String) async -> PlayerTitle? {
        await perform("player title") {
            try await self.getPlayerTitleByIdUseCase.execute(uuid: uuid).data
        }
    }

    func getCurrency(uuid: String) async -> GameCurrency? {
        await perform("currency") {
            try await self.getCurrencyByIdUseCase.execute(uuid: uuid).data
        }
    }

    private func perform<Value>(_ name: String, _ operation: () async throws -> Value) async -> Value? {
        do {
            return try await operation()
        } catch {
            let networkError = NetworkError(error)
            if case .cancelled = networkError { return nil }

            print("Failed to fetch \(name) data: \(networkError.localizedDescription)")
            self.error = networkError
            return nil
        }
    }
}

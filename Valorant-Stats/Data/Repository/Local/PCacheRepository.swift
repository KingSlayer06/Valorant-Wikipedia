//
//  PCacheRepository.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 17/11/26.
//

import Foundation

protocol PCacheRepository<Item>: Sendable {
    associatedtype Item

    func fetchAll() async throws -> [Item]
    func replaceAll(with items: [Item]) async throws
}

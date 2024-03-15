//
//  BaseRepository.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 15/03/24.
//

import Foundation

protocol PBaseRepository {
    associatedtype T
    
    func getAll() -> [T]
    func add(_ item: T)
    func save()
}

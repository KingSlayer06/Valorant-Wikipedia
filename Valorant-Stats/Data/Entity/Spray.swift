//
//  Spray.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 27/02/24.
//

import Foundation

struct Spray: Codable {
    let uuid: String
    let isNullSpray: Bool
    let fullTransparentIcon: String?
    let animationPng: String?
    let animationGif: String?
}

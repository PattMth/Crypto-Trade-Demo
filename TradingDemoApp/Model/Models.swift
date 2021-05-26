//
//  Models.swift
//  CryptoTracker
//
//  Created by user189998 on 5/12/21.
//

import Foundation
//models of apis
struct Coins: Codable {
    let asset_id: String
    let name: String?
    let price_usd: Float?
    let id_icon: String?
}
struct simpleCoin: Codable{
    let asset_id: String
    let name: String?
    let price_usd: Float?
}
struct Logo: Codable {
    let asset_id: String
    let url: String
}
struct coinPrice: Codable{
    let price_usd: Float?
}

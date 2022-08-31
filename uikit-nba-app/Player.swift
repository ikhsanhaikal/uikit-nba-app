//
//  Player.swift
//  uikit-nba-app
//
//  Created by Ikhsan on 20/08/2022.
//

import Foundation

struct Player: Decodable {
    let playerId: Int
    let status: String
    let position: String
    let firstName: String
    let lastName: String
    let photoUrl: String
    let nbaDotComPlayerId: Int?
    let jersey: Int?
    let height: Int?
    let weight: Int?
    let birthCity: String?
    let birthState: String?
    let birthCountry: String?
    
    
    var nbaPhotoHeadshot: String? {
        get {
            guard let nbaDotComPlayerId = nbaDotComPlayerId else {
                return nil
            }
            return "https://cdn.nba.com/headshots/nba/latest/1040x760/\(nbaDotComPlayerId).png"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case playerId = "PlayerID"
        case status   = "Status"
        case position = "Position"
        case firstName = "FirstName"
        case lastName = "LastName"
        case photoUrl = "PhotoUrl"
        case nbaDotComPlayerId = "NbaDotComPlayerID"
        case jersey = "Jersey"
        case height = "Height"
        case weight = "Weight"
        case birthCity = "BirthCity"
        case birthState = "BirthState"
        case birthCountry = "BirthCountry"
    }
    
}

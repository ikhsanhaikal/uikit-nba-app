//
//  Player.swift
//  uikit-nba-app
//
//  Created by Ikhsan on 20/08/2022.
//

import Foundation

struct Player: Decodable {
    let playerId: Int
    let active: String
    let position: String
    let firstName: String
    let lastName: String
    let photoUrl: String
    let nbaDotComPlayerId: String
    let jersey: Int
    let height: Int
    let weight: Int
    let birthCity: String
    let birthState: String
    let birthCountry: String
    
    
    var nbaPhotoHeadshot: String {
        get {
            "https://cdn.nba.com/headshots/nba/latest/1040x760/\(nbaDotComPlayerId).png"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case playerId = "PlayerID"
        case active   = "Active"
        case position = "Position"
        case firstName = "FirstName"
        case lastName = "LastName"
        case photoUrl = "PhotoUrl"
        case nbaDotComPlayerId = "NbaDotComTeamID"
        case jersey = "Jersey"
        case height = "Height"
        case weight = "Weight"
        case birthCity = "BirthCity"
        case birthState = "BirthState"
        case birthCountry = "BirthCountry"
    }
    
}

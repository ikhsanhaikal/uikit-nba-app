//
//  Team.swift
//  uikit-nba-app
//
//  Created by Ikhsan on 20/08/2022.
//

import Foundation

struct Team: Decodable {
    let teamId: Int
    let nbaDotComTeamId: Int
    let key: String
    let city: String
    let name: String
    let conference: String?
    let division: String?
    let primaryColor: String?
    let secondaryColor: String?
    let wikipediaLogoUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case teamId = "TeamID"
        case nbaDotComTeamId = "NbaDotComTeamID"
        case key = "Key"
        case city = "City"
        case name = "Name"
        case conference = "Conference"
        case division = "Division"
        case primaryColor = "PrimaryColor"
        case secondaryColor = "SecondaryColor"
        case wikipediaLogoUrl = "WikipediaLogoUrl"
    }
}

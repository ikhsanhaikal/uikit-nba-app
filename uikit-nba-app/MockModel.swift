//
//  MockModel.swift
//  uikit-nba-app
//
//  Created by Ikhsan on 21/08/2022.
//

import Foundation

class MockModel {
    static let mockJson =
    """
    [
        {
            "TeamID": 6,
            "Key": "NY",
            "Active": true,
            "City": "New York",
            "Name": "Knicks",
            "LeagueID": 3,
            "StadiumID": 6,
            "Conference": "Eastern",
            "Division": "Atlantic",
            "PrimaryColor": "006BB6",
            "SecondaryColor": "F58426",
            "TertiaryColor": "BEC0C2",
            "QuaternaryColor": "000000",
            "WikipediaLogoUrl": "https://upload.wikimedia.org/wikipedia/en/2/25/New_York_Knicks_logo.svg",
            "WikipediaWordMarkUrl": "",
            "GlobalTeamID": 20000006,
            "NbaDotComTeamID": 1610612752
        },
        {
            "TeamID": 7,
            "Key": "PHI",
            "Active": true,
            "City": "Philadelphia",
            "Name": "76ers",
            "LeagueID": 3,
            "StadiumID": 7,
            "Conference": "Eastern",
            "Division": "Atlantic",
            "PrimaryColor": "006BB6",
            "SecondaryColor": "ED174C",
            "TertiaryColor": "002B5C",
            "QuaternaryColor": "C4CED4",
            "WikipediaLogoUrl": "https://upload.wikimedia.org/wikipedia/en/0/0e/Philadelphia_76ers_logo.svg",
            "WikipediaWordMarkUrl": null,
            "GlobalTeamID": 20000007,
            "NbaDotComTeamID": 1610612755
        },
        {
            "TeamID": 8,
            "Key": "BKN",
            "Active": true,
            "City": "Brooklyn",
            "Name": "Nets",
            "LeagueID": 3,
            "StadiumID": 8,
            "Conference": "Eastern",
            "Division": "Atlantic",
            "PrimaryColor": "000000",
            "SecondaryColor": "FFFFFF",
            "TertiaryColor": "707271",
            "QuaternaryColor": null,
            "WikipediaLogoUrl": "https://upload.wikimedia.org/wikipedia/commons/4/44/Brooklyn_Nets_newlogo.svg",
            "WikipediaWordMarkUrl": null,
            "GlobalTeamID": 20000008,
            "NbaDotComTeamID": 1610612751
        },
        {
            "TeamID": 9,
            "Key": "BOS",
            "Active": true,
            "City": "Boston",
            "Name": "Celtics",
            "LeagueID": 3,
            "StadiumID": 9,
            "Conference": "Eastern",
            "Division": "Atlantic",
            "PrimaryColor": "008348",
            "SecondaryColor": "BB9753",
            "TertiaryColor": "000000",
            "QuaternaryColor": "FFFFFF",
            "WikipediaLogoUrl": "https://upload.wikimedia.org/wikipedia/en/8/8f/Boston_Celtics.svg",
            "WikipediaWordMarkUrl": null,
            "GlobalTeamID": 20000009,
            "NbaDotComTeamID": 1610612738
        },
        {
            "TeamID": 10,
            "Key": "TOR",
            "Active": true,
            "City": "Toronto",
            "Name": "Raptors",
            "LeagueID": 3,
            "StadiumID": 10,
            "Conference": "Eastern",
            "Division": "Atlantic",
            "PrimaryColor": "CE1141",
            "SecondaryColor": "000000",
            "TertiaryColor": "A1A1A4",
            "QuaternaryColor": "B4975A",
            "WikipediaLogoUrl": "https://upload.wikimedia.org/wikipedia/en/3/36/Toronto_Raptors_logo.svg",
            "WikipediaWordMarkUrl": null,
            "GlobalTeamID": 20000010,
            "NbaDotComTeamID": 1610612761
        },
        {
            "TeamID": 11,
            "Key": "CHI",
            "Active": true,
            "City": "Chicago",
            "Name": "Bulls",
            "LeagueID": 3,
            "StadiumID": 11,
            "Conference": "Eastern",
            "Division": "Central",
            "PrimaryColor": "CE1141",
            "SecondaryColor": "000000",
            "TertiaryColor": "",
            "QuaternaryColor": "",
            "WikipediaLogoUrl": "https://upload.wikimedia.org/wikipedia/en/6/67/Chicago_Bulls_logo.svg",
            "WikipediaWordMarkUrl": "",
            "GlobalTeamID": 20000011,
            "NbaDotComTeamID": 1610612741
        }
    ]
    """
    
    static var mockData: [Team] {
        if let data = try? JSONDecoder().decode([Team].self, from: Data(mockJson.utf8)) {
            return data
        } else {
            return []
        }
    }
    
}

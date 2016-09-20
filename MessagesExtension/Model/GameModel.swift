//
//  GameModel.swift
//  Tic Tac Toe for Messages
//
//  Created by Keli'i Martin on 9/19/16.
//  Copyright © 2016 WERUreo. All rights reserved.
//

import Foundation
import Messages

struct GameModel
{
    let xLocations: [Int]?
    let oLocations: [Int]?
    var turn: PlayerType = .x
    var isComplete: Bool = false
}

////////////////////////////////////////////////////////////
// MARK: - Encoding
////////////////////////////////////////////////////////////

extension GameModel
{
    func encode() -> URL
    {
        let baseURL = "www.werureo.com/tictactoe"

        guard var components = URLComponents(string: baseURL) else
        {
            fatalError("Invalid base url")
        }

        var items = [URLQueryItem]()

        // Locations of X's on the board
        let xLocationItems = self.xLocations?.map
        { location in
            URLQueryItem(name: "X_Location", value: String(location))
        }

        items.append(contentsOf: xLocationItems!)

        // Locations of O's on the board
        let oLocationItems = self.oLocations?.map
        { location in
            URLQueryItem(name: "O_Location", value: String(location))
        }

        items.append(contentsOf: oLocationItems!)

        // Who's turn is it?
        let turnItem = URLQueryItem(name: "Turn", value: self.turn.rawValue)
        items.append(turnItem)

        // Game Complete
        let complete = self.isComplete ? "1" : "0"

        let completeItem = URLQueryItem(name: "Is_Complete", value: complete)
        items.append(completeItem)

        components.queryItems = items

        guard let url = components.url else
        {
            fatalError("Invalid URL components")
        }

        return url
    }
}

////////////////////////////////////////////////////////////
// MARK: - Decoding from conversation
////////////////////////////////////////////////////////////

extension GameModel
{
    init(from url: URL)
    {
        // Parse the url
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
            let componentItems = components.queryItems else
        {
                fatalError("Invalid message url")
        }

        self.xLocations = componentItems.filter({ $0.name == "X_Location" }).map({ Int($0.value!)! })
        self.oLocations = componentItems.filter({ $0.name == "O_Location" }).map({ Int($0.value!)! })

        let turnQueryItem = componentItems.filter({ $0.name == "Turn" }).first!
        self.turn = PlayerType(rawValue: turnQueryItem.value!)!

        let completeQueryItem = componentItems.filter({ $0.name == "Is_Complete" }).first!
        self.isComplete = completeQueryItem.value! == "1"
    }
}

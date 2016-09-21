//
//  GameConstants.swift
//  Tic Tac Toe for Messages
//
//  Created by Keli'i Martin on 9/19/16.
//  Copyright © 2016 WERUreo. All rights reserved.
//

import Foundation

enum PlayerType: String { case x, o }

struct GameConstants
{
    // These combinations of cells are what is required to win the game
    static let winningCells =
    [
        [0, 1, 2], [3, 4, 5], [6, 7, 8],
        [0, 3, 6], [1, 4, 7], [2, 5, 8],
        [0, 4, 8], [2, 4, 6]
    ]

    static let gameBoardSize = 9
}

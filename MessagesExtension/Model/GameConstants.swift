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
    let winningCells =
    [
        [1, 2, 3], [4, 5, 6], [7, 8, 9],
        [1, 4, 7], [2, 5, 8], [3, 6, 9],
        [1, 5, 9], [3, 5, 7]
    ]
}

//
//  Player.swift
//  MVCBattleship
//
//  Created by zef on 3/10/17.
//  Copyright © 2017 zef. All rights reserved.
//

import UIKit

class Player {
    var name: String
    var thisPlayerTurn: Bool
    var hits: Int
    var misses: Int
    var shots: Int
    var ships: Int
    var board: Board
    
    init() {
        name = ""
        thisPlayerTurn = false
        hits = 0
        misses = 0
        shots = 0
        ships = 17
        board = Board()
    }
}

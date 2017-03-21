//
//  Cell.swift
//  MVCBattleship
//
//  Created by u0082100 on 3/17/17.
//  Copyright © 2017 zef. All rights reserved.
//

import Foundation


struct Cell {
    var row: Int
    var col: Int
    var value: Grid.CELL_VALUE
    
    init() {
        row = 0
        col = 0
        value = Grid.CELL_VALUE.WATER
    }
}

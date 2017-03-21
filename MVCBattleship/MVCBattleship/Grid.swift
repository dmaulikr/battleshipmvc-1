//
//  Grid.swift
//  MVCBattleship
//
//  Created by zef on 3/10/17.
//  Copyright © 2017 zef. All rights reserved.
//

import UIKit

class Grid {
    enum CELL_VALUE {
        case WATER
        case HIT
        case MISS
        case SHIP
    }
    
    // grid is made of SIZE x SIZE squares
    static let SIZE: Int = 10
    
    private var gridCells: [[Cell]]
    
    init() {
        gridCells = Array(repeating: Array(repeating: Cell(), count: Grid.SIZE), count: Grid.SIZE)
        for i in 0..<Grid.SIZE {
            for j in 0..<Grid.SIZE {
                gridCells[i][j] = Cell()
            }
        }
    }
    
    func getCell (column: Int, row: Int) -> Cell {
        return gridCells[column][row]
    }
    
    func setCell (column: Int, row: Int, value: CELL_VALUE) {
        gridCells[column][row].value = value
    }
    
}

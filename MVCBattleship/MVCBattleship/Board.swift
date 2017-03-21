//
//  Board.swift
//  MVCBattleship
//
//  Created by zef on 3/10/17.
//  Copyright © 2017 zef. All rights reserved.
//

import UIKit

class Board {
    
    var grid: Grid = Grid()
    var shipCells: [String] = [String]()
    var shipLength5 = Ship(shiplength: 5)
    var shipLength4 = Ship(shiplength: 4)
    var shipLength3A = Ship(shiplength: 3)
    var shipLength3B = Ship(shiplength: 3)
    var shipLength2 = Ship(shiplength: 2)
    
    func putShipsOnGrid() {
        putShipAtRandomLocation(ship: shipLength5)
        putShipAtRandomLocation(ship: shipLength4)
        putShipAtRandomLocation(ship: shipLength3A)
        putShipAtRandomLocation(ship: shipLength3B)
        putShipAtRandomLocation(ship: shipLength2)
    }
    
    func putShipAtRandomLocation(ship: Ship) {
        // generate a 0 or a 1 randomly. If 0 will place ship
        // horizontally, if 1 will place it vertically
        let orientation: Int = (Int)(arc4random_uniform(2))
        var done: Bool = false
        if orientation == 0 {
            // keep trying until we are able to place ship horizontally
            while  !done {
                done = putShipHorizontally(ship: ship)
            }
        }
        else {
            // keep trying until we are able to place ship vertically
            while !done {
                done = putShipVertically(ship: ship)
            }
        }
    }
    
    func putShipHorizontally(ship: Ship)-> Bool {
        var column: Int = (Int)(arc4random_uniform(UInt32(Grid.SIZE)))
        var row: Int = (Int)(arc4random_uniform(UInt32(Grid.SIZE)))
        
        while (column + ship.length > Grid.SIZE-1) {
            column = (Int)(arc4random_uniform(UInt32(Grid.SIZE)))
            row = (Int)(arc4random_uniform(UInt32(Grid.SIZE)))
        }
        
        for col in 0..<ship.length {
            if grid.getCell(column: column + col, row: row).value == Grid.CELL_VALUE.SHIP {
                return false
            }
        }
        
        for col in 0..<ship.length {
            shipCells.append("\(row),\(column + col)")
            grid.setCell(column: column + col, row: row, value: Grid.CELL_VALUE.SHIP)
        }
        return true
    }
    
    func putShipVertically(ship: Ship)-> Bool {
        var column: Int = (Int)(arc4random_uniform(UInt32(Grid.SIZE)))
        var row: Int = (Int)(arc4random_uniform(UInt32(Grid.SIZE)))
        
        while (row + ship.length > Grid.SIZE-1) {
            column = (Int)(arc4random_uniform(UInt32(Grid.SIZE)))
            row = (Int)(arc4random_uniform(UInt32(Grid.SIZE)))
        }
        
        for r in 0..<ship.length {
            if grid.getCell(column: column, row: row + r).value == Grid.CELL_VALUE.SHIP {
                return false
            }
        }
        
        for r in 0..<ship.length {
            shipCells.append("\(row + r),\(column)")
            grid.setCell(column: column, row: row + r, value: Grid.CELL_VALUE.SHIP)
        }
        return true

    }
}

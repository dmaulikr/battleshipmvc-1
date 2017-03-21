//
//  Game.swift
//  MVCBattleship
//
//  Created by zef on 3/10/17.
//  Copyright © 2017 zef. All rights reserved.
//

import UIKit

class Game {
    var player1: Player = Player()
    var player2: Player = Player()
    var currentPlayer: Player?
    var oppositePlayer: Player?
    var gameOver: Bool = false
    var winnerName: String = "N/A"
    
    
    init(player1Name: String, player2Name: String) {
        player1.name = player1Name
        player1.thisPlayerTurn = true
        player1.board.putShipsOnGrid()
        player2.name = player2Name
        player2.thisPlayerTurn = false
        player2.board.putShipsOnGrid()
        currentPlayer = player1
        oppositePlayer = player2
    }
    
    init(dictionary: NSDictionary) {
        gameOver = dictionary.value(forKey: "gameOver") as! Bool
        winnerName = dictionary.value(forKey: "winnerName") as! String
        let currentPlayerName: String = dictionary.value(forKey: "currentPlayerName") as! String
        player1.name = dictionary.value(forKey: "player1Name") as! String
        
        player1.thisPlayerTurn = dictionary.value(forKey: "isPlayer1Turn") as! Bool
        player1.hits = dictionary.value(forKey: "player1Hits") as! Int
        player1.misses = dictionary.value(forKey: "player1Misses") as! Int
        player1.ships = dictionary.value(forKey: "player1Ships") as! Int
        let player1GridCells: [[String]] = dictionary.value(forKey: "player1GridCells") as! [[String]]
        for i in 0..<Grid.SIZE {
            for j in 0..<Grid.SIZE {
                if player1GridCells[i][j] == "SHIP" {
                    player1.board.grid.setCell(column: i,row: j,value: Grid.CELL_VALUE.SHIP)
                }
                else if player1GridCells[i][j] == "MISS" {
                    player1.board.grid.setCell(column: i,row: j, value: Grid.CELL_VALUE.MISS)
                }
                else if player1GridCells[i][j] == "HIT" {
                    player1.board.grid.setCell(column: i,row: j, value: Grid.CELL_VALUE.HIT)
                }
                else {
                     player1.board.grid.setCell(column: i,row: j, value: Grid.CELL_VALUE.WATER)
                }
            }
        }
        
        player2.name = dictionary.value(forKey: "player2Name") as! String
        player2.thisPlayerTurn = dictionary.value(forKey: "isPlayer2Turn") as! Bool
        player2.hits = dictionary.value(forKey: "player2Hits") as! Int
        player2.misses = dictionary.value(forKey: "player2Misses") as! Int
        player2.ships = dictionary.value(forKey: "player2Ships") as! Int
        let player2GridCells: [[String]] = dictionary.value(forKey: "player2GridCells") as! [[String]]
        for i in 0..<Grid.SIZE {
            for j in 0..<Grid.SIZE {
                if player2GridCells[i][j] == "SHIP" {
                    player2.board.grid.setCell(column: i,row: j, value: Grid.CELL_VALUE.SHIP)
                }
                else if player2GridCells[i][j] == "MISS" {
                    player2.board.grid.setCell(column: i,row: j, value: Grid.CELL_VALUE.MISS)
                }
                else if player2GridCells[i][j] == "HIT" {
                    player2.board.grid.setCell(column: i,row: j, value: Grid.CELL_VALUE.HIT)
                }
                else {
                    player2.board.grid.setCell(column: i,row: j, value: Grid.CELL_VALUE.WATER)
                }
            }
        }
        if currentPlayerName == player1.name {
            currentPlayer = player1
            oppositePlayer = player2
        }
        else {
            currentPlayer = player2
            oppositePlayer = player1
        }
    }
    
    func alternateTurn() {
        if player1.thisPlayerTurn {
            player1.thisPlayerTurn = false
            player2.thisPlayerTurn = true
            currentPlayer = player2
            oppositePlayer = player1
        }
        else {
            player2.thisPlayerTurn = false
            player1.thisPlayerTurn = true
            currentPlayer = player1
            oppositePlayer = player2
        }
    }
    
    func play(column: Int, row: Int, value: Grid.CELL_VALUE) {
        if player1.thisPlayerTurn {
            player2.board.grid.setCell(column: column, row: row, value: value)
        }
        else {
            player1.board.grid.setCell(column: column, row: row, value: value)
        }
    }
    
    public var dictionaryRepresentation: NSDictionary {
        var player1GridValues: [[String]] = Array(repeating: Array(repeating: "\(Grid.CELL_VALUE.WATER)", count: Grid.SIZE), count: Grid.SIZE)
        for i in 0..<Grid.SIZE {
            for j in 0..<Grid.SIZE {
                player1GridValues[i][j] = "\(player1.board.grid.getCell(column: i,row: j).value)"
            }
        }
        var player2GridValues: [[String]] = Array(repeating: Array(repeating: "\(Grid.CELL_VALUE.WATER)", count: Grid.SIZE), count: Grid.SIZE)
        for i in 0..<Grid.SIZE {
            for j in 0..<Grid.SIZE {
                player2GridValues[i][j] = "\(player2.board.grid.getCell(column: i,row: j).value)"
            }
        }
        let player1GridCells: NSArray = NSArray(array: player1GridValues)
        let player2GridCells: NSArray = NSArray(array: player2GridValues)
        return ["gameOver": gameOver, "winnerName": winnerName, "currentPlayerName": currentPlayer!.name,
        "player1Name": player1.name, "player2Name": player2.name, "isPlayer1Turn": player1.thisPlayerTurn,
        "isPlayer2Turn": player2.thisPlayerTurn, "player1Hits": player1.hits, "player1Misses": player1.misses,
        "player1Ships": player1.ships,"player2Hits": player2.hits, "player2Misses": player2.misses,
        "player2Ships": player2.ships,"player1GridCells": player1GridCells,"player2GridCells": player2GridCells]
    }
}

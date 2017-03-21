//
//  GameLibrary.swift
//  MVCBattleship
//
//  Created by zef on 3/13/17.
//  Copyright © 2017 zef. All rights reserved.
//

import UIKit

class GameLibrary {

    public static let Instance: GameLibrary = {
        let instance = GameLibrary()
        instance.load()
        return instance
    }()
    
    private var mGames: [Game] = [Game]()
    
    private var mCurrentGameIndex: Int = 0
        
    public func createGame(player1Name: String, player2Name: String) {
        let newGame = Game(player1Name: player1Name, player2Name: player2Name)
        mGames.append(newGame)
        mCurrentGameIndex = mGames.count - 1
        save()
    }
        
    public func getGame(index: Int)-> Game {
        return mGames[index]
    }
        
    public func getCurrentGame()-> Game {
        return mGames[mCurrentGameIndex]
    }
        
    public func setCurrentGame(index: Int) {
        if !mGames[index].gameOver {
           mCurrentGameIndex = index
        }
    }
        
    public func deleteGame(index: Int) {
        mGames.remove(at: index)
        save()
    }
        
    public func getNumGames()->Int {
        return mGames.count
    }
        
    func play(column: Int, row: Int, value: Grid.CELL_VALUE) {
        getCurrentGame().play(column: column, row: row, value: value)
        save()
    }
    
    public func load() {
        // Load from JSON file
        mGames.removeAll()
        var pathURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last
        pathURL = pathURL?.appendingPathComponent("Library.json")
        do {
//           let jsonData: Data = try Data(contentsOf: URL.init(fileURLWithPath: "/Users/Authenticated User/Desktop/Library.json"))
           let jsonData: Data = try Data(contentsOf: pathURL!)
           let gameDictionaries: [NSDictionary] = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [NSDictionary]
           for gameDictionary: NSDictionary in gameDictionaries {
               let game: Game = Game(dictionary: gameDictionary)
               mGames.append(game)
           }
        } catch {
            
        }
    }
    
    public func save() {
        // Save to JSON file
       // let path = Bundle.main.path(forResource: "Library", ofType: "json")
       // print(path!)
        var pathURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last
        pathURL = pathURL?.appendingPathComponent("Library.json")
      //  print (pathURL!)
//        
//        let path = Bundle.main.path(forResource: "/Users/Authenticated User/Desktop/Library", ofType: "json")
//        print(path)
//        let stream = OutputStream.init(toFileAtPath: "/Users/Authenticated User/Desktop/Library.json", append: false)
//        stream?.open()
//        JSONSerialization.writeJSONObject(["Test":"ObjectAtTestKey"], to: stream!, options: [], error: nil)
        var gameDictionaries: [NSDictionary] = []
        for game: Game in mGames {
            gameDictionaries.append(game.dictionaryRepresentation)
        }
        let jsonData = try! JSONSerialization.data(withJSONObject: gameDictionaries, options: .prettyPrinted)
      //  try! jsonData.write(to: URL.init(fileURLWithPath:"/Users/Authenticated User/Desktop/Library.json"))
        try! jsonData.write(to: pathURL!)
        
    }

}

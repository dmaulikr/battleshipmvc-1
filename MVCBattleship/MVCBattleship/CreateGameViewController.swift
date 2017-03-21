//
//  CreateGameViewController.swift
//  MVCBattleship
//
//  Created by zef on 3/11/17.
//  Copyright © 2017 zef. All rights reserved.
//

import UIKit

class CreateGameViewController: UIViewController, UITextFieldDelegate {
    private var games: GameLibrary = GameLibrary.Instance
    
    var createGameView: CreateGameView {
        return view as! CreateGameView
    }
    
    override func loadView() {
        view = CreateGameView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge()
        createGameView.startGameButton.addTarget(self, action: #selector(createGame), for: UIControlEvents.touchDown)
        createGameView.player1Text.delegate = self
        createGameView.player2Text.delegate = self
    }
    
    func createGame() {
        var player1Name: String = createGameView.player1Text.text!
        var player2Name: String = createGameView.player2Text.text!
        
        if player1Name.isEmpty {
            player1Name = "Player 1"
        }
        if player2Name.isEmpty {
            player2Name = "Player 2"
        }
        
        games.createGame(player1Name: player1Name, player2Name: player2Name)
        navigationController?.pushViewController(GameViewController(), animated: true)
    }
    
}

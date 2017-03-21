//
//  GameViewController.swift
//  MVCBattleship
//
//  Created by zef on 3/11/17.
//  Copyright © 2017 zef. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, GameViewDelegate {
    
    private var mGames: GameLibrary = GameLibrary.Instance
    private var mPlayer1View: GameView?
    private var mPlayer2View: GameView?
    private var mCurrentGame: Game?
    private var mPlayer1Turn: Bool = true
    
    var gameView: UICollectionView {
        return view as! UICollectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton: UIBarButtonItem = UIBarButtonItem(title: "Game List", style: UIBarButtonItemStyle.plain, target: self, action: #selector(GameViewController.backToList))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        
        let currentGame: Game = mGames.getCurrentGame()
        let player1Board = currentGame.player1.board
        let player2Board = currentGame.player2.board
        
        let navHeight: CGFloat = (self.navigationController?.navigationBar.frame.size.height)!
        
        mPlayer1View = GameView(frame: view.bounds, currentPlayerBoard: player1Board, oppositePlayerBoard: player2Board, navHeight: navHeight)
        mPlayer1View?.gameViewDelegate = self
        mPlayer2View = GameView(frame: view.bounds, currentPlayerBoard: player2Board, oppositePlayerBoard: player1Board, navHeight: navHeight)
        mPlayer2View?.gameViewDelegate = self
        
        mCurrentGame = mGames.getCurrentGame()
        mPlayer1Turn = (mCurrentGame?.player1.thisPlayerTurn)!
        if mPlayer1Turn {
            view = mPlayer1View
        }
        else {
            view = mPlayer2View
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mPlayer1Turn = (mCurrentGame?.player1.thisPlayerTurn)!
        if mPlayer1Turn {
            view = mPlayer1View
            mPlayer1View?.nextTurnButton.isEnabled = false
            mPlayer1View?.nextTurnButton.backgroundColor = UIColor.lightGray
            mPlayer1View?.oppositePlayerGridView.touched = false
            mPlayer1View?.setNeedsDisplay()
            mPlayer2View?.setNeedsDisplay()
            mPlayer1View?.updateStats()

            mPlayer1View?.currentPlayerGridView.setNeedsDisplay()
            mPlayer1View?.oppositePlayerGridView.setNeedsDisplay()
        }
        else {
            view = mPlayer2View
            mPlayer2View?.nextTurnButton.isEnabled = false
            mPlayer2View?.nextTurnButton.backgroundColor = UIColor.lightGray
            mPlayer2View?.oppositePlayerGridView.touched = false

            mPlayer2View?.currentPlayerGridView.setNeedsDisplay()
            mPlayer2View?.oppositePlayerGridView.setNeedsDisplay()
            mPlayer2View?.updateStats()
        }
        if (mCurrentGame?.gameOver)! {
            self.title = "\((mCurrentGame?.winnerName)!) won"
        }
        else {
            self.title = "\((mCurrentGame?.currentPlayer?.name)!) Turn"
        }
    }
    
    func backToList() {
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    func switchPlayerTurns() {
        present(TransitionController(), animated: false, completion: nil)
    }
    
   }

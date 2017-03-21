//
//  GameView.swift
//  MVCBattleship
//
//  Created by zef on 3/13/17.
//  Copyright © 2017 zef. All rights reserved.
//

import UIKit

protocol GameViewDelegate: class {
    func switchPlayerTurns()
}

class GameView: UIView, GridViewDelegate {
    private var mGames: GameLibrary = GameLibrary.Instance
    private var mCurrentPlayerBoard: Board?
    private var mCurrentPlayerGrid: GridView!
    private var mOppositePlayerBoard: Board?
    private var mOppositePlayerGrid: GridView!
    private var mHitsLabel: UILabel = UILabel()
    private var mMissesLabel: UILabel = UILabel()
    private var mShipsLabel: UILabel = UILabel()
    private var mShipsLeftLabel: UILabel = UILabel()
    private var mNextTurnButton: UIButton = UIButton()
    private var mCurrentGame: Game?
    private var mNavHeight: CGFloat = 0
    weak var gameViewDelegate: GameViewDelegate?
    
    init(frame: CGRect, currentPlayerBoard: Board, oppositePlayerBoard: Board, navHeight: CGFloat) {
        super.init(frame: frame)
        mCurrentPlayerBoard = currentPlayerBoard
        mOppositePlayerBoard = oppositePlayerBoard
        mNavHeight = navHeight
        
        mCurrentGame = mGames.getCurrentGame()
        mCurrentPlayerGrid = GridView(frame: CGRect(x: CGFloat(Grid.SIZE), y: 2*navHeight + CGFloat(Grid.SIZE), width: frame.width / 2, height: frame.width / 2), grid: (mCurrentPlayerBoard?.grid)!, currentPlayerGrid: true)
        mCurrentPlayerGrid.gridViewDelegate = self
        
        mOppositePlayerGrid = GridView(frame: CGRect(x: CGFloat(Grid.SIZE), y: (frame.width/2) + 2*navHeight + 3 * CGFloat(Grid.SIZE), width: frame.width/2, height: frame.width / 2), grid: (mOppositePlayerBoard?.grid)!, currentPlayerGrid: false)
        mOppositePlayerGrid.gridViewDelegate = self
        
        addSubview(mCurrentPlayerGrid)
        addSubview(mOppositePlayerGrid)
        
        mHitsLabel.text = "Hits: 0"
        mHitsLabel.textColor = UIColor.white
        mHitsLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        mHitsLabel.frame = CGRect(x: frame.width/2 + 40, y: 3*navHeight, width: frame.width/3, height: navHeight)
        
        addSubview(mHitsLabel)
        
        mMissesLabel.text = "Misses: 0"
        mMissesLabel.textColor = UIColor.white
        mMissesLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        mMissesLabel.frame = CGRect(x: frame.width/2 + 40, y: 4*navHeight, width: frame.width/3, height: navHeight)
        
        addSubview(mMissesLabel)
        
        mShipsLabel.text = "Ships: 17"
        mShipsLabel.textColor = UIColor.white
        mShipsLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        mShipsLabel.frame = CGRect(x: frame.width/2 + 40, y: 5*navHeight, width: frame.width/3, height: navHeight)
        
        addSubview(mShipsLabel)
        
        mShipsLeftLabel.text = "Opponent Ships: 17"
        mShipsLeftLabel.textColor = UIColor.white
        mShipsLeftLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        mShipsLeftLabel.frame = CGRect(x: frame.width/2 + 40, y: 6*navHeight, width: frame.width/3, height: navHeight)
        
        addSubview(mShipsLeftLabel)
        
        mNextTurnButton = UIButton()
        mNextTurnButton.addTarget(self, action: #selector(switchTurns), for: UIControlEvents.touchDown)
        mNextTurnButton.backgroundColor = UIColor.lightGray
        mNextTurnButton.layer.cornerRadius = 10
        mNextTurnButton.setTitle("Next Turn", for: UIControlState())
        mNextTurnButton.isEnabled = false
        mNextTurnButton.frame = CGRect(x: frame.width/2 + 40, y: 7*navHeight, width: frame.width / 3, height: navHeight)
        
        addSubview(mNextTurnButton)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var nextTurnButton: UIButton {
        get {
            return mNextTurnButton
        }
    }
    
    public var currentPlayerGridView: GridView {
        get {
            return mCurrentPlayerGrid
        }
        
    }
    
    public var oppositePlayerGridView: GridView {
        get {
            return mOppositePlayerGrid
        }
    }
    
    func switchTurns(_ sender: UIButton) {
        gameViewDelegate?.switchPlayerTurns()
    }
    
    func updateGame(column: Int, row: Int, hit: Bool) {
        if hit {
            mGames.getCurrentGame().currentPlayer?.hits += 1
            mGames.getCurrentGame().oppositePlayer?.ships -= 1
            
            if mGames.getCurrentGame().oppositePlayer?.ships == 0 {
                mGames.getCurrentGame().gameOver = true
                mGames.getCurrentGame().winnerName = (mGames.getCurrentGame().currentPlayer?.name)!
            }
            // update each players boards
            mGames.play(column: column, row: row, value: Grid.CELL_VALUE.HIT)
        }
        else {
            mGames.getCurrentGame().currentPlayer?.misses += 1
        }
        mCurrentGame = mGames.getCurrentGame()
        // update stats labels
        updateStats()
        // enable next turn button if game is not over
        if !mGames.getCurrentGame().gameOver {
            mNextTurnButton.isEnabled = true
            mNextTurnButton.backgroundColor = UIColor.green
            // next turn
            mCurrentGame?.alternateTurn()
        }
        else {
            let winAlert: UIAlertView = UIAlertView(title:"Game Ends",
                                                    message: "\(mGames.getCurrentGame().winnerName) wins",
                delegate: self,
                cancelButtonTitle:"OK")
          
            winAlert.show()
//            let defaultAction = UIAlertAction(title:"Close", style: .default, handler: nil)
  //          winAlert.addAction(defaultAction)
            
            
        }
        
        mGames.save()
    }
    
    public func updateStats() {
        mHitsLabel.text = "Hits: \((mCurrentGame?.currentPlayer?.hits)!)"
        mMissesLabel.text = "Misses: \((mCurrentGame?.currentPlayer?.misses)!)"
        mShipsLabel.text = "Ships: \((mCurrentGame?.currentPlayer?.ships)!)"
        mShipsLeftLabel.text = "Opponent Ships: \((mCurrentGame?.oppositePlayer?.ships)!)"
    }
    
    override func layoutSubviews() {
        mCurrentGame = mGames.getCurrentGame()
        if bounds.height > bounds.width {
            
            mCurrentPlayerGrid.removeFromSuperview()
            mCurrentPlayerGrid = GridView(frame: CGRect(x: CGFloat(Grid.SIZE), y: 2*mNavHeight + CGFloat(Grid.SIZE), width: frame.width / 2, height: frame.width / 2), grid: (mCurrentPlayerBoard?.grid)!, currentPlayerGrid: true)
            mCurrentPlayerGrid.gridViewDelegate = self
            addSubview(mCurrentPlayerGrid)
        
            mOppositePlayerGrid.removeFromSuperview()
            mOppositePlayerGrid = GridView(frame: CGRect(x: CGFloat(Grid.SIZE), y: (frame.width/2) + 2*mNavHeight + 3 * CGFloat(Grid.SIZE), width: frame.width/2, height: frame.width / 2), grid: (mOppositePlayerBoard?.grid)!, currentPlayerGrid: false)
            mOppositePlayerGrid.gridViewDelegate = self
            addSubview(mOppositePlayerGrid)
            
            mHitsLabel.frame = CGRect(x: frame.width/2 + 40, y: 3*mNavHeight, width: frame.width/3, height: mNavHeight)
            mMissesLabel.frame = CGRect(x: frame.width/2 + 40, y: 4*mNavHeight, width: frame.width/3, height: mNavHeight)
            mShipsLabel.frame = CGRect(x: frame.width/2 + 40, y: 5*mNavHeight, width: frame.width/3, height: mNavHeight)
            mShipsLeftLabel.frame = CGRect(x: frame.width/2 + 40, y: 6*mNavHeight, width: frame.width/3, height: mNavHeight)
            mNextTurnButton.frame = CGRect(x: frame.width/2 + 40, y: 7*mNavHeight, width: frame.width / 3, height: mNavHeight)
            
        }
        else {
            mCurrentPlayerGrid.removeFromSuperview()
            mCurrentPlayerGrid = GridView(frame: CGRect(x: CGFloat(2*Grid.SIZE), y: mNavHeight + CGFloat(Grid.SIZE), width: frame.height / 1.5, height: frame.height / 1.5), grid: (mCurrentPlayerBoard?.grid)!, currentPlayerGrid: true)
            mCurrentPlayerGrid.gridViewDelegate = self
            addSubview(mCurrentPlayerGrid)
            
            mOppositePlayerGrid.removeFromSuperview()
            mOppositePlayerGrid = GridView(frame: CGRect(x: frame.width - frame.height, y: mNavHeight + CGFloat(Grid.SIZE), width: frame.height / 1.5, height: frame.height / 1.5), grid: (mOppositePlayerBoard?.grid)!, currentPlayerGrid: false)
            mOppositePlayerGrid.gridViewDelegate = self
            addSubview(mOppositePlayerGrid)
            
            mHitsLabel.frame = CGRect(x: frame.height/3 + 30, y: mNavHeight + CGFloat(Grid.SIZE) + (frame.height / 1.5), width: frame.height/3, height: mNavHeight)
            mMissesLabel.frame = CGRect(x: frame.height/3 + 30, y: 1.5*mNavHeight + CGFloat(Grid.SIZE) + (frame.height / 1.5), width: frame.height/3, height: mNavHeight)
            mShipsLabel.frame = CGRect(x: frame.height/3 + 30, y: 2.0*mNavHeight + CGFloat(Grid.SIZE) + (frame.height / 1.5), width: frame.height/3, height: mNavHeight)
            mShipsLeftLabel.frame = CGRect(x: frame.height/3 + 130, y: mNavHeight + CGFloat(Grid.SIZE) + (frame.height / 1.5), width: frame.height/3, height: mNavHeight)
            mNextTurnButton.frame = CGRect(x: frame.height/3 + 130, y: 1.8*mNavHeight + CGFloat(Grid.SIZE) + (frame.height / 1.5), width: frame.height / 3, height: mNavHeight)
        }
    }
}

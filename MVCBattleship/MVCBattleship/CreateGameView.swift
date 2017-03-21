//
//  CreateGameView.swift
//  MVCBattleship
//
//  Created by zef on 3/11/17.
//  Copyright © 2017 zef. All rights reserved.
//

import UIKit

class CreateGameView: UIView {
    
    private var mPlayer1Lbl: UILabel = UILabel()
    private var mPlayer1Text: UITextField = UITextField()
    private var mPlayer2Lbl: UILabel = UILabel()
    private var mPlayer2Text: UITextField = UITextField()
    private var mStartGameButton: UIButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect())
        
        self.backgroundColor = UIColor.darkGray
        
        mPlayer1Lbl.text = "Player 1 name: "
        mPlayer1Lbl.textColor = UIColor.white
        addSubview(mPlayer1Lbl)
        
        mPlayer1Text.placeholder = " Name of player 1 "
        mPlayer1Text.backgroundColor = UIColor.white
        mPlayer1Text.textAlignment = NSTextAlignment.center
        addSubview(mPlayer1Text)
        
        mPlayer2Lbl.text = "Player 2 name: "
        mPlayer2Lbl.textColor = UIColor.white
        addSubview(mPlayer2Lbl)
        
        mPlayer2Text.placeholder = " Name of player 2 "
        mPlayer2Text.backgroundColor = UIColor.white
        mPlayer2Text.textAlignment = NSTextAlignment.center
        addSubview(mPlayer2Text)
        
        mStartGameButton.setTitle("Start", for: UIControlState())
        mStartGameButton.backgroundColor = UIColor.blue
        mStartGameButton.layer.cornerRadius = 12
        addSubview(mStartGameButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var startGameButton: UIButton {
        return mStartGameButton
    }
    
    public var player1Text: UITextField {
        return mPlayer1Text
    }
    
    public var player2Text: UITextField {
        return mPlayer2Text
    }
    
    // lay the elements in the form correctly
    override func layoutSubviews() {
        if(bounds.height > bounds.width) {
            mPlayer1Lbl.frame = CGRect(x: self.bounds.width / 2 - 100, y: 90, width: 200, height: 20)
            mPlayer1Text.frame = CGRect(x: self.bounds.width / 2 - 100, y: 120, width: 200, height: 50)
            mPlayer2Lbl.frame = CGRect(x: self.bounds.width / 2 - 100, y: 190, width: 200, height: 20)
            mPlayer2Text.frame = CGRect(x: self.bounds.width / 2 - 100, y: 220, width: 200, height: 50)
            mStartGameButton.frame = CGRect(x: self.bounds.width / 2 - 100, y: 350, width: 200, height: 60)
        }
        else {
            mPlayer1Lbl.frame = CGRect(x: self.bounds.width / 2 - 100, y: 15, width: 200, height: 20)
            mPlayer1Text.frame = CGRect(x: self.bounds.width / 2 - 100, y: 40, width: 200, height: 50)
            mPlayer2Lbl.frame = CGRect(x: self.bounds.width / 2 - 100, y: 100, width: 200, height: 20)
            mPlayer2Text.frame = CGRect(x: self.bounds.width / 2 - 100, y: 125, width: 200, height: 50)
            mStartGameButton.frame = CGRect(x: self.bounds.width / 2 - 100, y: 200, width: 200, height: 60)
        }
    }
}

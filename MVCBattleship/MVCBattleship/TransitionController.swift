//
//  TransitionController.swift
//  MVCBattleship
//
//  Created by zef on 3/18/17.
//  Copyright © 2017 zef. All rights reserved.
//

import UIKit

class TransitionController: UIViewController {
    
    private var mGames: GameLibrary = GameLibrary.Instance
    private var mPassLabel: UILabel = UILabel()
    private var mPassButton: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.lightGray
        
        
        mPassLabel.frame = CGRect(x: view.bounds.width / 2 - 100 , y: view.bounds.height / 2 - 50, width: 300, height: 20)
        mPassLabel.text = "Pass console to \((mGames.getCurrentGame().currentPlayer?.name)!)"
        mPassLabel.textColor = UIColor.white
        view.addSubview(mPassLabel)
        
        mPassButton.frame = CGRect(x: view.bounds.width / 2 - 100 , y: view.bounds.height / 2 - 25, width: 200, height: 50)
        mPassButton.setTitle("Pass", for: UIControlState())
        mPassButton.backgroundColor = UIColor.green
        mPassButton.addTarget(self, action: #selector(passDevice), for: UIControlEvents.touchUpInside)
        view.addSubview(mPassButton)
        
    }
    
    func passDevice() {
        presentingViewController?.dismiss(animated: false, completion: nil)
    }
}

//
//  GameListViewController.swift
//  MVCBattleship
//
//  Created by zef on 3/11/17.
//  Copyright © 2017 zef. All rights reserved.
//

import UIKit

class GameListViewController: UITableViewController {
    
    private var mGames: GameLibrary = GameLibrary.Instance
    
    override func loadView() {
        view = UITableView(frame: CGRect.zero, style: UITableViewStyle.grouped)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MVC Battleship"
        self.view.backgroundColor = UIColor.lightGray
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector (GameListViewController.createGame))
        self.navigationItem.leftBarButtonItem = editButtonItem
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        tableView.separatorColor = UIColor.darkGray
        tableView.reloadData()
    }
    
    
    func createGame() {
        tableView.reloadData()
        navigationController?.pushViewController(CreateGameViewController(), animated: true)
        
        self.tableView.reloadData()
    }
    
    // MARK: - Table view functions
    // reload data when coming back to this view
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // number of items in the table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mGames.getNumGames()
    }
    
    // resume selected game
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index: Int = indexPath.row
        let game = mGames.getGame(index: index)
        
       // if !game.gameOver {
            mGames.setCurrentGame(index: index)
            navigationController?.pushViewController(GameViewController(), animated: true)
            tableView.reloadData()
       // }
    }
    
    // delete selected game
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            mGames.deleteGame(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        }
    }
    
    // make each table cell larger instead of the default 44 to accomodate three lines of text
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // load game data into table view cell and return cell to view
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index: Int = indexPath.row
        let game: Game = mGames.getGame(index: index)
        let player1: Player = game.player1
        let player2: Player = game.player2
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: nil)
        cell.contentView.backgroundColor = UIColor.white
       // cell.textLabel?.numberOfLines = 0
      //  cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        if game.gameOver {
            cell.textLabel?.text = " Game Over. Winner was " + game.winnerName
        }
        else {
            cell.textLabel?.text = " In progress. Next turn " + (game.currentPlayer?.name)!
        }
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.detailTextLabel?.text = "\(player1.name) hits: \(player1.hits) misses: \(player1.misses)  ships: \(player1.ships) \n\(player2.name) hits: \(player2.hits) misses:\(player2.misses) ships: \(player2.ships)"
        
        return cell
        
    }
    
}

//
//  GridView.swift
//  MVCBattleship
//
//  Created by zef on 3/11/17.
//  Copyright © 2017 zef. All rights reserved.
//

import UIKit


protocol GridViewDelegate: class {
    func updateGame (column: Int, row: Int, hit: Bool)
}


class GridView: UIView, CellViewDelegate {
    
    private var mGames: GameLibrary = GameLibrary.Instance
    private var mGrid: Grid?
    private var mCurrentPlayerGrid: Bool = true
    private var mTouched: Bool = false
    weak var gridViewDelegate: GridViewDelegate?
    
    init(frame: CGRect, grid: Grid, currentPlayerGrid: Bool) {
        super.init(frame: frame)
        mGrid = grid
        mCurrentPlayerGrid = currentPlayerGrid
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        // create a grid of cell subviews
        buildGrid()
    }
    
    public var touched: Bool {
        get {
            return mTouched
        }
        set {
            mTouched = newValue
        }
    }
    
    private func buildGrid() {
        let cellSize:CGFloat = CGFloat(1)/CGFloat(Grid.SIZE)
        let gameOver: Bool = mGames.getCurrentGame().gameOver
        for row in 0..<Grid.SIZE {
            for column in 0..<Grid.SIZE {
                let cellFrame: CGRect = CGRect(x: CGFloat(row) * (bounds.size.width * cellSize),
                                         y: CGFloat(column) * (bounds.size.height * cellSize),
                                         width: bounds.size.width * cellSize, height: bounds.size.height * cellSize)
                var cell: Cell = Cell()
                cell.col = column
                cell.row = row
                let cellValue: Grid.CELL_VALUE = (mGrid?.getCell(column: column, row: row).value)!
                // dont display ships for adversary grid
                if mCurrentPlayerGrid || (!mCurrentPlayerGrid && cellValue != Grid.CELL_VALUE.SHIP) {
                    cell.value = cellValue
                }
                let cellView: CellView = CellView(frame: cellFrame)
                cellView.cell = cell
                cellView.cellDelegate = self
                if gameOver || mCurrentPlayerGrid || mTouched {
                    cellView.updateCell = false
                }
                else if !mTouched {
                    cellView.updateCell = true
                }
                addSubview(cellView)
            }
        }
    }
    
    
    func updateCellView(_ row: Int, _ column: Int){        
        var cellValue: Grid.CELL_VALUE = (mGrid?.getCell(column: column, row: row).value)!
        var hit: Bool = false
        if cellValue == Grid.CELL_VALUE.SHIP {
            mGrid?.setCell(column: column, row: row, value: Grid.CELL_VALUE.HIT)
            cellValue = Grid.CELL_VALUE.HIT
            hit = true
        }
        else {
            mGrid?.setCell(column: column, row: row, value: Grid.CELL_VALUE.MISS)
            cellValue = Grid.CELL_VALUE.MISS
            
        }
       
        // update the cell color
        var cellView: CellView = (subviews[row * Grid.SIZE + column] as! CellView)
        cellView.cell.value = cellValue
        // disable touch on all cells
        for i in 0..<Grid.SIZE*Grid.SIZE {
            cellView = (subviews[i] as! CellView)
            cellView.updateCell = false
        }
        mTouched = true
        setNeedsDisplay()
        gridViewDelegate?.updateGame(column: column, row: row, hit: hit)
    }
}

//
//  CellView.swift
//  MVCBattleship
//
//  Created by zef on 3/17/17.
//  Copyright © 2017 zef. All rights reserved.
//

import UIKit

protocol CellViewDelegate: class {
    func updateCellView (_ row: Int, _ column: Int)
}

class CellView: UIView {
    
    private var mCell: Cell = Cell()
    private var mGameOver: Bool = false
    private var mUpdateCell: Bool = true
    weak var cellDelegate: CellViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public var cell: Cell {
        get {
            return mCell
        }
        set {
            mCell = newValue
            setNeedsDisplay()
        }
    }
    
    public var updateCell: Bool {
        get {
            return mUpdateCell
        }
        set {
            mUpdateCell = newValue
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let cellColor = getCellColor()
        let context = UIGraphicsGetCurrentContext()!
        let x = bounds.origin.x + 1
        let y = bounds.origin.y + 1
        let width = bounds.size.width - 2
        let height = bounds.size.width - 2
        let cell = CGRect(x: x, y: y, width: width, height: height)
        context.addRect(cell)
        context.setFillColor(cellColor.cgColor)
        context.fill(cell)
    }
    
    
    private func getCellColor()-> UIColor {
        var cellColor: UIColor
        switch mCell.value {
        case .HIT:
            cellColor = UIColor.red
        case .MISS:
            cellColor = UIColor.white
        case .SHIP:
            cellColor = UIColor.brown
        case .WATER:
            cellColor = UIColor.blue
        }
        
        return cellColor
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if mUpdateCell {
             cellDelegate?.updateCellView(mCell.row, mCell.col)
        }
    }

}

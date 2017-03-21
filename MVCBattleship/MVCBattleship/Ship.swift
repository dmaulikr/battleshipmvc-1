//
//  Ship.swift
//  MVCBattleship
//
//  Created by zef on 3/10/17.
//  Copyright © 2017 zef. All rights reserved.
//

import UIKit

class Ship {
    var length: Int
    var sunk: Bool
    
    init(shiplength: Int) {
        length = shiplength
        sunk = false
    }
}

//
//  PlayerModel.swift
//  TicTacToe
//
//  Created by Vidya on 04/12/19.
//  Copyright © 2019 VidyaPrasad. All rights reserved.
//

import UIKit

struct Player {
    var name: String?
    var playerId: Int = 0
    var isWon = false
    var textColor = UIColor.black
    var isActive = false
}

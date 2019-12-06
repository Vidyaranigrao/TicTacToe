//
//  BoardCollectionViewCell.swift
//  TicTacToe
//
//  Created by Vidya on 04/12/19.
//  Copyright © 2019 VidyaPrasad. All rights reserved.
//

import UIKit

class BoardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var markLabel: UILabel!
    var playerId = 0
    
    func setUp() {
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.black.cgColor
        self.markLabel.text = ""
        self.playerId = 0
    }
}

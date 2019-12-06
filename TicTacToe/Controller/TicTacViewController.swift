//
//  TicTacViewController.swift
//  TicTacToe
//
//  Created by Vidya on 04/12/19.
//  Copyright © 2019 VidyaPrasad. All rights reserved.
//

import UIKit

class TicTacViewController: UIViewController {
    
    @IBOutlet weak var playerInfoLabel: UILabel!
    @IBOutlet weak var boardCollectionView: UICollectionView!
    @IBOutlet weak var buttonStackView: UIStackView!
    
    var gridSize = 3
    var player1Name = ""
    var player2Name = ""
    var numberOfturns = 0
    var player1 = Player()
    var player2 = Player()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetUp()
    }
    
    func initialSetUp() {
        if self.player1Name == "" {
            self.player1.name = "Player 1"
        } else {
            self.player1.name = self.player1Name
        }
        if self.player2Name == "" {
            self.player2.name = "Player 2"
        } else {
            self.player2.name = self.player2Name
        }
        self.player1.isActive = true
        self.player1.playerId = 1
        self.player2.textColor = .white
        self.player2.playerId = 2
        self.updateTurns()
        self.buttonStackView.isHidden = true
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        boardCollectionView.delegate = self
        boardCollectionView.dataSource = self
        boardCollectionView.collectionViewLayout = flowLayout
        let padding = (UIScreen.main.bounds.width - (CGFloat(gridSize) * Constants.cellWidth)) / 2.0
        let gridHeight = Constants.cellHeight * CGFloat(gridSize)
        let topPadding = (boardCollectionView.bounds.height - gridHeight) / 2
        let top = topPadding < 0 ? 0 : topPadding
        boardCollectionView.contentInset = UIEdgeInsets(top: top, left: padding, bottom: 0, right: padding);

    }
    
    @IBAction func playAgainButtonTapped(_ sender: Any) {
        self.player1.isActive = true
        self.player1.isWon = false
        self.player2.isWon = false
        numberOfturns = 0
        self.updateTurns()
        boardCollectionView.reloadData()
        self.buttonStackView.isHidden = true
        self.boardCollectionView.isUserInteractionEnabled = true
    }
    
    @IBAction func exitButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showMessage(msg: String) {
        self.playerInfoLabel.text = msg
        self.buttonStackView.isHidden = false
        self.boardCollectionView.isUserInteractionEnabled = false
    }
    
    func updateBoard() {
        if player1.isWon {
            self.showMessage(msg: "\(player1.name!) Won!")
        } else if player2.isWon {
            self.showMessage(msg: "\(player2.name!) Won!")
        }
    }
    func updateTurns() {
        if player1.isActive {
            self.playerInfoLabel.text = "\(self.player1.name!) turn"
        }else{
            self.playerInfoLabel.text = "\(self.player2.name!) turn"
        }
    }
    
    func checkForRows() {
        for column in 0 ..< self.gridSize {
            var p1Won = true
            var p2Won = true
            for row in 0 ..< self.gridSize {
                let cell = boardCollectionView.cellForItem(at: IndexPath(row: row, section: column)) as! BoardCollectionViewCell
                if cell.playerId != player1.playerId {
                    p1Won = false
                }
                if cell.playerId != player2.playerId {
                    p2Won = false
                }
            }
            if p1Won{
                player1.isWon = true
                break
            }else if p2Won{
                player2.isWon = true
                break
            }
        }
        
        if !player1.isWon && !player2.isWon {
            self.checkForColumns()
        } else {
            self.updateBoard()
        }
    }
    
    func checkForColumns() {
        for row in 0 ..< self.gridSize {
            var p1Won = true
            var p2Won = true

            for column in 0 ..< self.gridSize {
                let cell = boardCollectionView.cellForItem(at: IndexPath.init(row: row, section: column)) as! BoardCollectionViewCell
                if cell.playerId != player1.playerId{
                    p1Won = false
                }
                if cell.playerId != player2.playerId{
                    p2Won = false
                }
            }
            if p1Won {
                player1.isWon = true
                break
            }else if p2Won {
                player2.isWon = true
                break
            }
        }
        if !player1.isWon && !player2.isWon {
            self.checkDiagonals()
        } else {
            self.updateBoard()
        }
    }
    
    func checkDiagonals() {
        var p1Won = true
        var p2Won = true
        
        for row in 0 ..< self.gridSize {
            let cell = boardCollectionView.cellForItem(at: IndexPath.init(row: row, section: row)) as! BoardCollectionViewCell
            if cell.playerId != player1.playerId{
                p1Won = false
            }
            if cell.playerId != player2.playerId{
                p2Won = false
            }
        }
        if p1Won {
            player1.isWon = true
            self.updateBoard()
            return
        }else if p2Won {
            player2.isWon = true
            self.updateBoard()
            return
        }else{
            p1Won = true
            p2Won = true
        }
        
        //Left Diagonal Check
        for row in 0 ..< self.gridSize {
            let cell = boardCollectionView.cellForItem(at: IndexPath.init(row: row, section:  (self.gridSize - 1) - row)) as! BoardCollectionViewCell
            if cell.playerId != player1.playerId{
                p1Won = false
            }
            if cell.playerId != player2.playerId{
                p2Won = false
            }
        }
        if p1Won {
            player1.isWon = true
            return
        }else if p2Won {
            player2.isWon = true
            return
        }else{
            p1Won = true
            p2Won = true
        }
    }
    
    func checkForWinner() {
        self.checkForRows()
        if numberOfturns ==  gridSize * gridSize {
            if !player1.isWon && !player2.isWon{
                self.showMessage(msg: "It's a Draw")
            }
        }
    }
}

extension TicTacViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! BoardCollectionViewCell
        if cell.markLabel.text == "" {
            self.numberOfturns += 1
            if player1.isActive {
                cell.markLabel.text = "X"
                cell.markLabel.textColor = player1.textColor
                cell.playerId = player1.playerId
                player1.isActive = false
                player2.isActive = true
            }else{
                cell.markLabel.text = "O"
                cell.playerId = player2.playerId
                cell.markLabel.textColor = player2.textColor
                player2.isActive = false
                player1.isActive = true
            }
            self.updateTurns()
            let minNumberOfturns = (2 * self.gridSize) - 1
            if minNumberOfturns <= numberOfturns {
                self.checkForWinner()
            }
        }
    }
}

extension TicTacViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return gridSize
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gridSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell  = boardCollectionView.dequeueReusableCell(withReuseIdentifier: "boardCell", for: indexPath) as! BoardCollectionViewCell
        cell.setUp()
        return cell
    }
}

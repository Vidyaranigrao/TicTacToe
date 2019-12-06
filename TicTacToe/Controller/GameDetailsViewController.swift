//
//  GameDetailsViewController.swift
//  TicTacToe
//
//  Created by Vidya on 04/12/19.
//  Copyright © 2019 VidyaPrasad. All rights reserved.
//

import UIKit

enum Constants {
    static let cellWidth: CGFloat = 50
    static let cellHeight: CGFloat = 50
}

class GameDetailsViewController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var player2TextField: UITextField!
    @IBOutlet weak var player1TextField: UITextField!
    @IBOutlet weak var gridSizeTextField: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // determine the grid size based on the screen size
    let maxGridSize = Int(UIScreen.main.bounds.width/Constants.cellWidth)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetUp()
    }
    
    func initialSetUp() {
        self.gridSizeTextField.placeholder = "Please enter grid size"
        self.gridSizeTextField.text = "3"
        self.gridSizeTextField.delegate = self
        
        self.player1TextField.placeholder = "Please enter Player 1 name"
        self.player1TextField.delegate = self
        self.player2TextField.placeholder = "Please enter PLayer 2 name"
        self.player2TextField.delegate = self
        self.enablePlayButton()
        self.descriptionLabel.text = "(Grid Size can vary between 3 and \(maxGridSize))"
    }
    
    func enablePlayButton() {
        guard let _ = self.gridSizeTextField.text else {
            self.playButton.isEnabled = false
            return
        }
        self.playButton.isEnabled = true
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
        self.gridSizeTextField.resignFirstResponder()
        self.player1TextField.resignFirstResponder()
        self.player2TextField.resignFirstResponder()
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TicTacToe")
        if let controller = vc as? TicTacViewController {
            controller.gridSize = Int(self.gridSizeTextField.text!) ?? 3
            controller.player1Name = self.player1TextField.text ?? "Player 1"
            controller.player2Name = self.player2TextField.text ?? "Player 2"
            self.present(controller, animated: true, completion: nil)
        }
    }
}

extension GameDetailsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.gridSizeTextField {
            enablePlayButton()
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.gridSizeTextField {
            // enable play button once the user enters valid grid size
            if let text = textField.text as NSString? {
                let updatedText = text.replacingCharacters(in: range, with: string)
                if let intValue = Int(updatedText) {
                    if (intValue > maxGridSize || intValue < 3) {
                        self.playButton.isEnabled = false
                    } else {
                        self.playButton.isEnabled = true
                    }
                } else {
                    self.playButton.isEnabled = false
                }
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.gridSizeTextField {
            self.player1TextField.becomeFirstResponder()
        } else if textField == self.player1TextField {
            self.player2TextField.becomeFirstResponder()
        } else {
            player2TextField.resignFirstResponder()
        }
        return true
    }
}

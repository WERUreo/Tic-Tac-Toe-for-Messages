//
//  GameBoardVC.swift
//  Tic Tac Toe for Messages
//
//  Created by Keli'i Martin on 9/15/16.
//  Copyright © 2016 WERUreo. All rights reserved.
//

import UIKit
import Messages

class GameBoardVC: MSMessagesAppViewController
{
    ////////////////////////////////////////////////////////////
    // MARK: - IBOutlets
    ////////////////////////////////////////////////////////////

    @IBOutlet weak var gameBoard: GameBoardView!
    @IBOutlet weak var endTurnButton: UIButton!
    
    ////////////////////////////////////////////////////////////
    // MARK: - Properties
    ////////////////////////////////////////////////////////////

    var onLocationSelectionComplete: ((_ gameState: GameModel, _ snapshot: UIImage) -> Void)?
    var wasCellSelected: Bool = false
    var selectedCell: Int?
    var model: GameModel!
    var currentPlayer: PlayerType = .x

    ////////////////////////////////////////////////////////////
    // MARK: - View Controller Life Cycle
    ////////////////////////////////////////////////////////////

    override func viewDidLoad()
    {
        super.viewDidLoad()

        if model.isComplete
        {
            let alert = UIAlertController(title: "Game Complete!", message: "The game's already finished!", preferredStyle: .alert)
            present(alert, animated: true)
            self.gameBoard.isHidden = true
            self.endTurnButton.isHidden = true
            return
        }

        // Make sure we know how's turn it is, X or O
        self.currentPlayer = model.turn
        setupBoard()

        gameBoard.onCellSelection =
        { [unowned self]
          location in

            if self.wasCellSelected
            {
                self.gameBoard.alterCell(at: self.selectedCell!, applying: .deselected)
            }
            self.gameBoard.toggleCellStyle(at: location, for: self.currentPlayer)
            self.selectedCell = location
            self.wasCellSelected = true
        }
    }

    ////////////////////////////////////////////////////////////
    // MARK: - IBActions
    ////////////////////////////////////////////////////////////

    @IBAction func endTurnTapped(_ sender: AnyObject)
    {
        let model = GameModel(xLocations: self.gameBoard.selectedCells(of: .selectedX), oLocations: self.gameBoard.selectedCells(of: .selectedO), turn: togglePlayer(), isComplete: false)
        onLocationSelectionComplete?(model, UIImage.snapshot(from: gameBoard))
    }
}

extension GameBoardVC
{
    func setupBoard()
    {
        if let xLocations = model.xLocations
        {
            for xLocation in xLocations
            {
                gameBoard.alterCell(at: xLocation, applying: .selectedX)
            }
        }

        if let oLocations = model.oLocations
        {
            for oLocation in oLocations
            {
                gameBoard.alterCell(at: oLocation, applying: .selectedO)
            }
        }
    }

    ////////////////////////////////////////////////////////////

    func togglePlayer() -> PlayerType
    {
        return (self.currentPlayer == .x) ? .o : .x
    }

    ////////////////////////////////////////////////////////////

    func checkGameCompletion()
    {
        
    }
}

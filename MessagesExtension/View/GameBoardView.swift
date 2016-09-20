//
//  GameBoardView.swift
//  Tic Tac Toe for Messages
//
//  Created by Keli'i Martin on 9/15/16.
//  Copyright © 2016 WERUreo. All rights reserved.
//

import UIKit

class GameBoardView: UICollectionView
{
    enum CellStyle
    {
        case selectedX
        case selectedO
        case deselected
    }

    ////////////////////////////////////////////////////////////
    // MARK: - Properties
    ////////////////////////////////////////////////////////////

    fileprivate var cellStyles = Array(repeating: CellStyle.deselected, count: 9)
    var onCellSelection: ((_ cellLocation: Int) -> Void)?

    ////////////////////////////////////////////////////////////
    // MARK: - Initializer
    ////////////////////////////////////////////////////////////

    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)

        register(UICollectionViewCell.self, forCellWithReuseIdentifier: "GameCell")

        dataSource = self
        delegate = self

        if let layout = collectionViewLayout as? UICollectionViewFlowLayout
        {
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }

        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }

    ////////////////////////////////////////////////////////////

    override func layoutSubviews()
    {
        super.layoutSubviews()
        contentOffset = CGPoint(x: 0, y: 0)
    }
}

////////////////////////////////////////////////////////////

extension GameBoardView
{
    func selectedCells(of type: CellStyle) -> [Int]?
    {
        var cells = [Int]()

        for (index, selected) in self.cellStyles.enumerated() where selected == type
        {
            cells.append(index)
        }

        return cells
    }

    ////////////////////////////////////////////////////////////

    func reset()
    {
        self.cellStyles = Array(repeating: .deselected, count: 9)
        reloadData()
        layoutIfNeeded()
    }

    ////////////////////////////////////////////////////////////

    func toggleCellStyle(at cellIndex: Int, for turn: PlayerType)
    {
        let playTurn: CellStyle = turn == .x ? .selectedX : .selectedO
        let style: CellStyle = cellStyles[cellIndex] == playTurn ? .deselected : playTurn
        alterCell(at: cellIndex, applying: style)
    }

    ////////////////////////////////////////////////////////////

    func alterCell(at index: Int, applying selectionStyle: CellStyle)
    {
        cellStyles[index] = selectionStyle
        let path = IndexPath(row: index, section: 0)
        if let cell = cellForItem(at: path)
        {
            decorate(cell, for: selectionStyle)
        }
    }

    ////////////////////////////////////////////////////////////

    fileprivate func decorate(_ cell: UICollectionViewCell, for style: CellStyle)
    {
        switch style
        {
            case .selectedX:
                cell.backgroundColor = .green
            case .selectedO:
                cell.backgroundColor = .red
            case .deselected:
                cell.backgroundColor = UIColor(red:0.33, green:0.43, blue:0.54, alpha:1.00)
        }
    }
}

////////////////////////////////////////////////////////////
// MARK: - UICollectionViewDataSource
////////////////////////////////////////////////////////////

extension GameBoardView: UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }

    ////////////////////////////////////////////////////////////

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 9
    }

    ////////////////////////////////////////////////////////////

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath)
        cell.layer.borderWidth = 5
        cell.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor

        decorate(cell, for: cellStyles[indexPath.row])

        return cell
    }
}

////////////////////////////////////////////////////////////
// MARK: - UICollectionViewDelegate
////////////////////////////////////////////////////////////

extension GameBoardView: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let cellsPerRow: CGFloat = 3
        let perimeterLength = floor(superview!.bounds.width / cellsPerRow)

        return CGSize(width: perimeterLength, height: perimeterLength)
    }

    ////////////////////////////////////////////////////////////

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        onCellSelection?(indexPath.row)
    }
}

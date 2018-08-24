//
//  SudokuPuzzleViewModelLoadGrid.swift
//  SudokuSolver
//
//  Created by Shawn Collins on 2018-08-24.
//  Copyright © 2018 Shawn Collins. All rights reserved.
//

import Foundation

struct SudokuCellViewModelFromRowColumnPair: SudokuCellViewModel {
    let cell: Cell
    let rowAndColumn: RowColumnPair
    
    var number: Int? {
        return cell.currentValue
    }
    
    var position: CellPosition {
        let (squareX, squareY) = (rowAndColumn.column % 3, rowAndColumn.row % 3)
        switch (squareX, squareY) {
        case (0, 0): return .topLeft
        case (0, 1): return .middleLeft
        case (0, 2): return .bottomLeft
        case (1, 0): return .topMiddle
        case (1, 1): return .middleMiddle
        case (1, 2): return .bottomMiddle
        case (2, 0): return .topRight
        case (2, 1): return .middleRight
        case (2, 2): return .bottomRight
        default:
            fatalError("Invalid position provided \(rowAndColumn)")
        }
    }
}

class SudokuPuzzleViewModelLoadGrid: SudokuPuzzleViewModel {
    
    let model: SudokuPuzzleModel
    let initialGrid: Grid
    
    init(grid: Grid) {
        self.initialGrid = grid
        model = SudokuPuzzleModel(puzzle: grid)
    }
    
    func cell(at index: Int) -> SudokuCellViewModel {
        let rowColumn = RowColumnPair(row: index / 9, column: index % 9)
        let cell = model.cell(at: rowColumn)
        let cellViewModel = SudokuCellViewModelFromRowColumnPair(cell: cell, rowAndColumn: rowColumn)
        return cellViewModel
    }
    
    func solvePuzzle(_ handler: @escaping PuzzleSolvingProgress) {
        model.solvePuzzle(handler)
    }
    
    func resetPuzzle() {
        model.puzzle = initialGrid
    }
}

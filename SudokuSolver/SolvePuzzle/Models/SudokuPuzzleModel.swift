//
//  SudokuPuzzleModel.swift
//  SudokuSolver
//
//  Created by Shawn Collins on 2018-08-23.
//  Copyright © 2018 Shawn Collins. All rights reserved.
//

import Foundation

typealias RowColumnPair = (row: Int, column: Int)
class SudokuPuzzleModel {
    var puzzle = Grid(cells: Array(repeating: Array(repeating: Cell.candidate(nil), count: 9), count: 9))
    
    func cell(at location: RowColumnPair) -> Cell {
        return puzzle.cells[location.row][location.column]
    }
}

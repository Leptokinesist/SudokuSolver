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
    var puzzle: Grid
    
    init(puzzle: Grid) {
        self.puzzle = puzzle
    }
    
    func cell(at location: RowColumnPair) -> Cell {
        return puzzle.cells[location.row][location.column]
    }
    
    func solvePuzzle(_ handler: @escaping (_ done: Bool, _ error: Error?) -> Void) {
        // TODO: Create new async task call for solving puzzle
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.puzzle = Grid(cells: Array(repeating: Array(repeating: Cell.candidate(4), count: 9), count: 9))
            handler(true, nil)
        })
    }
}

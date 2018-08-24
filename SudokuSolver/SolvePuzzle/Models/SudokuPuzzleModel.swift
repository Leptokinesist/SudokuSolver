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
        /*
         Create new async task call for solving puzzle (supports long processing times, but faked for now)
         as we want to display a spinner while "solving" in case the algorithm is still working away
         Note: A better approach would be to throttle this at the view layer for better UX
         */
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: { [weak self] in
            guard let strongSelf = self else { return }
            
            BruteForceSudokuSolver().solveGrid(strongSelf.puzzle) {[weak self] solvedGrid, solvingError in
                guard let strongSelf = self else { return }
                
                if let puzzle = solvedGrid {
                    strongSelf.puzzle = puzzle
                    handler(true, solvingError)
                } else {
                    handler(false, solvingError)
                }
            }
        })
    }
}

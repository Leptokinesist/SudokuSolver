//
//  BruteForceSudokuSolver.swift
//  SudokuSolver
//
//  Created by Shawn Collins on 2018-08-24.
//  Copyright © 2018 Shawn Collins. All rights reserved.
//

import Foundation

struct BruteForceSudokuSolver: SudokuSolver {
    
    static func solveGrid(grid: Grid) -> Grid? {
        // If there's no empty cell, it's been solved!
        guard let nextCell = grid.nextEmptyCell else {
            return grid
        }
        var newGrid = grid
        for value in Array(1...9) {
            if newGrid.isValid(value: value, at: nextCell) {
                newGrid.cells[nextCell.row][nextCell.column] = .candidate(value)
                
                // If this is the solvable branch, then we can return the solution
                if let solvedGrid = BruteForceSudokuSolver.solveGrid(grid: newGrid) {
                    return solvedGrid
                }
                
                // It wasn't the solvable branch, let's try something else
                newGrid.cells[nextCell.row][nextCell.column] = .candidate(nil)
            }
        }
        
        // No solution was found
        return nil
    }
    
    func solveGrid(_ grid: Grid, completion: (Grid?, Error?) -> Void) {
        guard let solvedGrid = BruteForceSudokuSolver.solveGrid(grid: grid) else {
            completion(nil, SolverError.unsolvable)
            return
        }
        
        completion(solvedGrid, nil)
    }
}

extension Grid {
    var nextEmptyCell: RowColumnPair? {
        for row in Array(0..<9) {
            for column in Array(0..<9) {
                if cells[row][column].currentValue == nil {
                    return RowColumnPair(row: row, column: column)
                }
            }
        }
        return nil
    }
}

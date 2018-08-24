//
//  Grid.swift
//  SudokuSolver
//
//  Created by Shawn Collins on 2018-08-23.
//  Copyright © 2018 Shawn Collins. All rights reserved.
//

import Foundation

struct Grid {
    var cells: [[Cell]]
    
    init(cells: [[Cell]] = Array(repeating: Array(repeating: Cell.value(7), count: 9), count: 9)) {
        self.cells = cells
    }
    
    init(intMatrix: [[Int]]) {
        self.cells = intMatrix.map { row in
            return row.map {value in
                if value == 0 {
                    return Cell.candidate(nil)
                }
                
                return Cell.value(value)
            }
        }
    }
    
    func isValid(value: Int, at location: RowColumnPair) -> Bool {
        return !isValue(value, usedInRow: location.row) &&
            !isValue(value, usedInColumn: location.column) &&
            !isValue(value, usedInSquare: RowColumnPair(row: location.row - (location.row % 3), column: location.column - (location.column % 3)))
    }
    
    private func isValue(_ value: Int, usedInRow row: Int) -> Bool {
        for column in Array(0..<9) {
            if let foundValue = cells[row][column].currentValue, foundValue == value {
                return true
            }
        }
        return false
    }
    
    private func isValue(_ value: Int, usedInColumn column: Int) -> Bool {
        for row in Array(0..<9) {
            if let foundValue = cells[row][column].currentValue, foundValue == value {
                return true
            }
        }
        return false
    }
    
    private func isValue(_ value: Int, usedInSquare location: RowColumnPair) -> Bool {
        for row in Array(0..<3) {
            for column in Array(0..<3) {
                if let foundValue = cells[row+location.row][column+location.column].currentValue, foundValue == value {
                    return true
                }
            }
        }
        return false
    }
}

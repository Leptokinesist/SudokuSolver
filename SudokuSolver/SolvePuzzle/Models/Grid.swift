//
//  Grid.swift
//  SudokuSolver
//
//  Created by Shawn Collins on 2018-08-23.
//  Copyright © 2018 Shawn Collins. All rights reserved.
//

import Foundation

struct Grid {
    let cells: [[Cell]]
    
    init(cells: [[Cell]] = Array(repeating: Array(repeating: Cell.value(7), count: 9), count: 9)) {
        self.cells = cells
    }
    
    func isValidValue(at location: RowColumnPair) -> Bool {
        return false
    }
    
    private func isValueUsed(inRow row: Int) -> Bool {
        return false
    }
    
    private func isValueUsed(inColumn column: Int) -> Bool {
        return false
    }
    
    private func isValueUsed(inSquare square: Int) -> Bool {
        return false
    }
}

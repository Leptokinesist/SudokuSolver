//
//  SudokuSolver.swift
//  SudokuSolver
//
//  Created by Shawn Collins on 2018-08-24.
//  Copyright © 2018 Shawn Collins. All rights reserved.
//

import Foundation

enum SolverError: Error {
    case unsolvable
}

typealias SolverCompletion = (_ solvedGrid: Grid?, _ error: Error?) -> Void

protocol SudokuSolver {
    func solveGrid(_ grid: Grid, completion: SolverCompletion)
}

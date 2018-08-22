//
//  SudokuPuzzleViewModel.swift
//  SudokuSolver
//
//  Created by Shawn Collins on 2018-08-22.
//  Copyright © 2018 Shawn Collins. All rights reserved.
//

import Foundation

typealias PuzzleSolvingProgress = (_ done: Bool, _ error: Error?) -> Void

protocol SudokuPuzzleViewModel {
    func getCell(at index: Int) -> SudokuCellViewModel
    func solvePuzzle(_: PuzzleSolvingProgress)
}

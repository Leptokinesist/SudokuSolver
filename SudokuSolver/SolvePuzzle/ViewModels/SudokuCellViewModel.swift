//
//  SudokuCellViewModel.swift
//  SudokuSolver
//
//  Created by Shawn Collins on 2018-08-22.
//  Copyright © 2018 Shawn Collins. All rights reserved.
//

import Foundation

enum CellPosition {
    case topLeft, topMiddle, topRight
    case middleLeft, middleMiddle, middleRight
    case bottomLeft, bottomMiddle, bottomRight
}

protocol SudokuCellViewModel {
    var number: Int? { get }
    var position: CellPosition { get }
}

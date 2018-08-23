//
//  Cell.swift
//  SudokuSolver
//
//  Created by Shawn Collins on 2018-08-23.
//  Copyright © 2018 Shawn Collins. All rights reserved.
//

import Foundation

enum Cell {
    case value(Int)
    case candidate(Int?)
    
    var currentValue: Int? {
        switch self {
        case .value(let val):
            return val
        case .candidate(let val):
            return val
        }
    }
}

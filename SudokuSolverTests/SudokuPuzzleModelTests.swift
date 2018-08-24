//
//  SudokuPuzzleModelTests.swift
//  SudokuPuzzleModelTests
//
//  Created by Shawn Collins on 2018-08-21.
//  Copyright © 2018 Shawn Collins. All rights reserved.
//

import XCTest
@testable import SudokuSolver

class SudokuPuzzleModelTests: XCTestCase {
    
    let testGrid: Grid = {
        let cells = Array(1...9).map {y -> [Cell] in
            let newRangeMin: Int = ((y-1)*9)+1
            let newRangeMax: Int = y*9
            return Array(newRangeMin...newRangeMax).map {x -> Cell in
                return Cell.value(x)
            }
        }
        return Grid(cells: cells)
    }()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPuzzleOrder() {
        let viewModel = SudokuPuzzleViewModelLoadGrid(grid: testGrid)
        
        for index in Array(0...80) {
            let cell = viewModel.cell(at: index)
            XCTAssertNotNil(cell.number, "Cell should have value")
            XCTAssertEqual(cell.number!, index + 1, "Cell should have expected value at index \(index)")
        }
        
    }
    
    func testSolvePuzzle() {
        
    }
    
}

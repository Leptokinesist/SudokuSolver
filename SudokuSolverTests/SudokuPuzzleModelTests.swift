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
    
    let testGridOrder: Grid = {
        let cells = Array(1...9).map {y -> [Cell] in
            let newRangeMin: Int = ((y-1)*9)+1
            let newRangeMax: Int = y*9
            return Array(newRangeMin...newRangeMax).map {x -> Cell in
                return Cell.value(x)
            }
        }
        return Grid(cells: cells)
    }()
    
    static let baseMatrix = [[5,3,0,0,7,0,0,0,0],
                             [6,0,0,1,9,5,0,0,0],
                             [0,9,8,0,0,0,0,6,0],
                             [8,0,0,0,6,0,0,0,3],
                             [4,0,0,8,0,3,0,0,1],
                             [7,0,0,0,2,0,0,0,6],
                             [0,6,0,0,0,0,2,8,0],
                             [0,0,0,4,1,9,0,0,5],
                             [0,0,0,0,8,0,0,7,9]]
    
    static let solvedMatrix = [[5,3,4,6,7,8,9,1,2],
                               [6,7,2,1,9,5,3,4,8],
                               [1,9,8,3,4,2,5,6,7],
                               [8,5,9,7,6,1,4,2,3],
                               [4,2,6,8,5,3,7,9,1],
                               [7,1,3,9,2,4,8,5,6],
                               [9,6,1,5,3,7,2,8,4],
                               [2,8,7,4,1,9,6,3,5],
                               [3,4,5,2,8,6,1,7,9]]
    
    let testGridSolvableBase = Grid(intMatrix: baseMatrix)
    let testGridSolved = Grid(intMatrix: solvedMatrix)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPuzzleOrder() {
        let viewModel = SudokuPuzzleViewModelLoadGrid(grid: testGridOrder)
        
        for index in Array(0...80) {
            let cell = viewModel.cell(at: index)
            XCTAssertNotNil(cell.number, "Cell should have value")
            XCTAssertEqual(cell.number!, index + 1, "Cell should have expected value at index \(index)")
        }
        
    }
    
    func testSolvePuzzle() {
        let expectationOfCallback = expectation(description: "CallBack need to fulfill this requirement")
        
        let viewModel = SudokuPuzzleViewModelLoadGrid(grid: testGridSolvableBase)
        viewModel.solvePuzzle{[unowned self] done, error in
            XCTAssertTrue(done, "Puzzle is solvable")
            XCTAssertNil(error, "No errors occurred")
            
            let solvedViewModel = SudokuPuzzleViewModelLoadGrid(grid: self.testGridSolved)
            
            for index in Array(0..<81) {
                XCTAssertEqual(viewModel.cell(at: index).number, solvedViewModel.cell(at: index).number, "ViewModels should match at this point")
            }
            expectationOfCallback.fulfill()
        }
        
        waitForExpectations(timeout: 20) { error in
            if let error = error {
                XCTFail("waitForExpectations errored: \(error)")
            }
        }
    }
    
}

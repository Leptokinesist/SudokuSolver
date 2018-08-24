//
//  PuzzleViewController.swift
//  SudokuSolver
//
//  Created by Shawn Collins on 2018-08-21.
//  Copyright © 2018 Shawn Collins. All rights reserved.
//

import UIKit

class PuzzleViewController: UIViewController {
    
    // Something you can modify/test with :D
    static let initialPuzzleGrid = Grid(intMatrix: [[5,3,0,0,7,0,0,0,0],
                                                    [6,0,0,1,9,5,0,0,0],
                                                    [0,9,8,0,0,0,0,6,0],
                                                    [8,0,0,0,6,0,0,0,3],
                                                    [4,0,0,8,0,3,0,0,1],
                                                    [7,0,0,0,2,0,0,0,6],
                                                    [0,6,0,0,0,0,2,8,0],
                                                    [0,0,0,4,1,9,0,0,5],
                                                    [0,0,0,0,8,0,0,7,9]])
    
    let viewModel = SudokuPuzzleViewModelLoadGrid(grid: initialPuzzleGrid)
    
    fileprivate lazy var gridViewSizeValue: CGFloat = { [unowned self] in
        // Smallest of width or height with spacing (in case of different orientations)
        return min(self.view.bounds.width * 0.9, self.view.bounds.height * 0.9)
    }()
    
    fileprivate lazy var gridCollectionView: UICollectionView = { [unowned self] in
        // Some basic setup, cellSizes are calculated in delegate
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        let grid = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        grid.isScrollEnabled = false
        grid.dataSource = self
        grid.delegate = self
        grid.register(SudokuCell.self, forCellWithReuseIdentifier: "SudokuCell")
        
        return grid
    }()
    
    let solveButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle(Constants.solveButtonSolveText, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitle(Constants.solveButtonSolvingText, for: .disabled)
        button.setTitleColor(UIColor.gray, for: .disabled)
        button.titleLabel?.font = UIFont.italicSystemFont(ofSize: 32.0)
        button.layer.cornerRadius = 10
        button.layer.borderColor = Constants.solveButtonBorderColor.cgColor
        button.layer.borderWidth = Constants.solveButtonBorderWidth
        button.clipsToBounds = true
        return button
    }()
    
    // Single point of configuration/value-setting
    fileprivate enum Constants {
        static let backgroundColor: UIColor = .cyan
        static let puzzleGridSize: CGFloat = 9
        static let solveButtonBorderColor: UIColor = .lightGray
        static let solveButtonBorderWidth: CGFloat = 2.0
        static let solveButtonSolveText = "Solve"
        static let solveButtonSolvingText = "Solving..."
        static let solveButtonResetText = "Reset"
    }
    
    var isButtonResetting: Bool {
        return solveButton.titleLabel?.text == Constants.solveButtonResetText
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constants.backgroundColor
        solveButton.addTarget(self, action: #selector(PuzzleViewController.solvePress), for: .touchUpInside)
        
        let views: [String: Any] = [
            "gridCollectionView": gridCollectionView,
            "solveButton": solveButton]
        gridCollectionView.translatesAutoresizingMaskIntoConstraints = false
        solveButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(gridCollectionView)
        view.addSubview(solveButton)
        
        var constraints = [NSLayoutConstraint]()
        constraints += [NSLayoutConstraint(item: gridCollectionView,
                                           attribute: NSLayoutAttribute.centerX,
                                           relatedBy: NSLayoutRelation.equal,
                                           toItem: view,
                                           attribute: .centerX,
                                           multiplier: 1,
                                           constant: 0),
                        NSLayoutConstraint(item: gridCollectionView,
                                           attribute: NSLayoutAttribute.centerY,
                                           relatedBy: NSLayoutRelation.equal,
                                           toItem: view,
                                           attribute: .centerY,
                                           multiplier: 1,
                                           constant: 0)]
        constraints += [NSLayoutConstraint(item: gridCollectionView,
                                           attribute: .width,
                                           relatedBy: .equal,
                                           toItem: gridCollectionView,
                                           attribute: .height,
                                           multiplier: 1,
                                           constant:0)]
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-(20)-[solveButton]-(20)-|",
                                                      options: NSLayoutFormatOptions(rawValue: 0),
                                                      metrics: nil,
                                                      views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-(>=15)-[gridCollectionView(\(self.gridViewSizeValue))]-(>=15)-[solveButton]-(20)-|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-(>=0)-[gridCollectionView(\(self.gridViewSizeValue))]-(>=0)-|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: views)
        
        view.addConstraints(constraints)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startSolving() {
        solveButton.isEnabled = false
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.frame = view.bounds
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        viewModel.solvePuzzle {[unowned self] done, error in
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            self.solveButton.isEnabled = true
            self.solveButton.setTitle(Constants.solveButtonResetText, for: .normal)
            self.gridCollectionView.reloadData()
            
            if let error = error {
                self.showToast(message: "An error occurred while solving the puzzle: \(error)")
            }
        }
    }
    
    func resetPuzzle() {
        viewModel.resetPuzzle()
        solveButton.setTitle(Constants.solveButtonSolveText, for: .normal)
        gridCollectionView.reloadData()
    }
    
    @objc
    func solvePress() {
        isButtonResetting ? resetPuzzle() : startSolving()
    }
}

extension PuzzleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(pow(Constants.puzzleGridSize, 2))
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SudokuCell", for: indexPath) as! SudokuCell
        cell.backgroundColor = UIColor.magenta
        cell.update(with: viewModel.cell(at: indexPath.item))
        return cell
    }
}

extension PuzzleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let emptySpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right + flowLayout.minimumInteritemSpacing * (Constants.puzzleGridSize - 1.0)
        let cellSizeValue = (collectionView.frame.width - emptySpace) / Constants.puzzleGridSize
        return CGSize(width: cellSizeValue, height: cellSizeValue)
    }
}

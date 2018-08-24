//
//  SudokuCell.swift
//  SudokuSolver
//
//  Created by Shawn Collins on 2018-08-22.
//  Copyright © 2018 Shawn Collins. All rights reserved.
//

import UIKit

class SudokuCell: UICollectionViewCell {
    
    private enum Constants {
        static let borderWidth: CGFloat = 1
        static let edgeBorderCGColor: CGColor = UIColor.black.cgColor
        static let middleBorderCGColor: CGColor = UIColor.gray.cgColor
    }
    
    private let valueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "0"
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var leftBorder: CALayer = { [unowned self] in
        let border = CALayer()
        border.frame = CGRect(x: 0, y: 0, width: Constants.borderWidth, height: self.frame.size.height)
        border.backgroundColor = UIColor.black.cgColor
        return border
    }()
    
    private lazy var topBorder: CALayer = { [unowned self] in
        let border = CALayer()
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: Constants.borderWidth)
        border.backgroundColor = UIColor.black.cgColor
        return border
    }()
    
    private lazy var bottomBorder: CALayer = { [unowned self] in
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.size.height - Constants.borderWidth, width: self.frame.size.width, height: Constants.borderWidth)
        border.backgroundColor = UIColor.black.cgColor
        return border
    }()
    
    private lazy var rightBorder: CALayer = { [unowned self] in
        let border = CALayer()
        border.frame = CGRect(x: self.frame.size.width - Constants.borderWidth, y: 0, width: Constants.borderWidth, height: self.frame.size.height)
        border.backgroundColor = UIColor.black.cgColor
        return border
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(valueLabel)
        layer.addSublayer(leftBorder)
        layer.addSublayer(topBorder)
        layer.addSublayer(bottomBorder)
        layer.addSublayer(rightBorder)
        
        let views: [String: Any] = ["valueLabel": valueLabel]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(\(Constants.borderWidth))-[valueLabel]-(\(Constants.borderWidth))-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(\(Constants.borderWidth))-[valueLabel]-(\(Constants.borderWidth))-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    }
    
    func update(with viewModel: SudokuCellViewModel) {
        if let numberValue = viewModel.number {
            valueLabel.text = String(numberValue)
        } else {
            valueLabel.text = ""
        }
        
        switch viewModel.position {
        case .topLeft:
            topBorder.backgroundColor = Constants.edgeBorderCGColor
            leftBorder.backgroundColor = Constants.edgeBorderCGColor
            rightBorder.backgroundColor = Constants.middleBorderCGColor
            bottomBorder.backgroundColor = Constants.middleBorderCGColor
        case .topMiddle:
            topBorder.backgroundColor = Constants.edgeBorderCGColor
            leftBorder.backgroundColor = Constants.middleBorderCGColor
            rightBorder.backgroundColor = Constants.middleBorderCGColor
            bottomBorder.backgroundColor = Constants.middleBorderCGColor
        case .topRight:
            topBorder.backgroundColor = Constants.edgeBorderCGColor
            leftBorder.backgroundColor = Constants.middleBorderCGColor
            rightBorder.backgroundColor = Constants.edgeBorderCGColor
            bottomBorder.backgroundColor = Constants.middleBorderCGColor
        case .middleLeft:
            topBorder.backgroundColor = Constants.middleBorderCGColor
            leftBorder.backgroundColor = Constants.edgeBorderCGColor
            rightBorder.backgroundColor = Constants.middleBorderCGColor
            bottomBorder.backgroundColor = Constants.middleBorderCGColor
        case .middleMiddle:
            topBorder.backgroundColor = Constants.middleBorderCGColor
            leftBorder.backgroundColor = Constants.middleBorderCGColor
            rightBorder.backgroundColor = Constants.middleBorderCGColor
            bottomBorder.backgroundColor = Constants.middleBorderCGColor
        case .middleRight:
            topBorder.backgroundColor = Constants.middleBorderCGColor
            leftBorder.backgroundColor = Constants.middleBorderCGColor
            rightBorder.backgroundColor = Constants.edgeBorderCGColor
            bottomBorder.backgroundColor = Constants.middleBorderCGColor
        case .bottomLeft:
            topBorder.backgroundColor = Constants.middleBorderCGColor
            leftBorder.backgroundColor = Constants.edgeBorderCGColor
            rightBorder.backgroundColor = Constants.middleBorderCGColor
            bottomBorder.backgroundColor = Constants.edgeBorderCGColor
        case .bottomMiddle:
            topBorder.backgroundColor = Constants.middleBorderCGColor
            leftBorder.backgroundColor = Constants.middleBorderCGColor
            rightBorder.backgroundColor = Constants.middleBorderCGColor
            bottomBorder.backgroundColor = Constants.edgeBorderCGColor
        case .bottomRight:
            topBorder.backgroundColor = Constants.middleBorderCGColor
            leftBorder.backgroundColor = Constants.middleBorderCGColor
            rightBorder.backgroundColor = Constants.edgeBorderCGColor
            bottomBorder.backgroundColor = Constants.edgeBorderCGColor
        }
    }
}

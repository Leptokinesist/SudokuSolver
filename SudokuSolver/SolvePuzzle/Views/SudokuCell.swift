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
    }
    
    let valueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "0"
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var leftBorder: CALayer = { [unowned self] in
        let border = CALayer()
        border.frame = CGRect(x: 0, y: 0, width: Constants.borderWidth, height: self.frame.size.height)
        border.backgroundColor = UIColor.black.cgColor
        return border
    }()
    
    lazy var topBorder: CALayer = { [unowned self] in
        let border = CALayer()
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: Constants.borderWidth)
        border.backgroundColor = UIColor.black.cgColor
        return border
    }()
    
    lazy var bottomBorder: CALayer = { [unowned self] in
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.size.height - Constants.borderWidth, width: self.frame.size.width, height: Constants.borderWidth)
        border.backgroundColor = UIColor.black.cgColor
        return border
    }()
    
    lazy var rightBorder: CALayer = { [unowned self] in
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
}

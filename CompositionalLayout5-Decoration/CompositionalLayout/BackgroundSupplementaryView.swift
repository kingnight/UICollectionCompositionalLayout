//
//  BackgroundSupplementaryView.swift
//  CompositionalLayout
//
//  Created by kai jin on 2023/8/10.
//

import UIKit

class BackgroundSupplementaryView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 8
        backgroundColor = UIColor(white: 0.85, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

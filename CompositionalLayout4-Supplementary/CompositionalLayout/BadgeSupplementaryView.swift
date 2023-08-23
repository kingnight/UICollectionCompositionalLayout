//
//  BadgeSupplementaryView.swift
//  CompositionalLayout
//
//  Created by kai jin on 2023/8/9.
//

import Foundation
import UIKit


class BadgeSupplementaryView: UICollectionReusableView {
    static let reuseIdentifer = "BadgeSupplementaryView"
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .green
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

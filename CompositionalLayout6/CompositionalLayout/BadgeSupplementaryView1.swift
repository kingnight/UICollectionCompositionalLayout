//
//  BadgeSupplementaryView1.swift
//  CompositionalLayout
//
//  Created by kai jin on 2023/8/10.
//

import UIKit

class BadgeSupplementaryView1: UICollectionReusableView {
    static let reuseIdentifer = "BadgeSupplementaryView1"
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

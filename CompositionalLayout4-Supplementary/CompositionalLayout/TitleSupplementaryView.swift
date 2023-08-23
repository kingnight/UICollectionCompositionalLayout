//
//  TitleSupplementaryView.swift
//  CompositionalLayout
//
//  Created by kai jin on 2023/8/10.
//

import Foundation
import UIKit

class TitleSupplementaryView: UICollectionReusableView {
    static let reuseIdentifer = "TitleSupplementaryView"
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(label)
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .center
        label.textColor = .black
    }
}

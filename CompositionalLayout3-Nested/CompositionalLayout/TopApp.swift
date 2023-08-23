//
//  TopApp.swift
//  CompositionalLayout
//
//  Created by kai jin on 2023/8/8.
//

import UIKit

class TopApp:UICollectionViewCell{
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var appImageView: UIImageView!
    static let reuseIdentifier = "TopApp"
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}

struct TopAppModel:Hashable {
    let imageNamed:String
    let title:String
    let subTitle:String
    let identifier = UUID().uuidString
    
    static var mock:[TopAppModel]{
        return [
            TopAppModel(imageNamed: "externaldrive.connected.to.line.below", title: "facebook title", subTitle: "facebook subtitle"),
            TopAppModel(imageNamed: "personalhotspot.circle.fill", title: "instagram title", subTitle: "instagram subtitle"),
            TopAppModel(imageNamed: "bolt.horizontal.fill", title: "linkedin title", subTitle: "linkedin subtitle")
            
        ]
    }
    
    static var mock2:[TopAppModel]{
        return [
            TopAppModel(imageNamed: "sun.min", title: "facebook title", subTitle: "facebook subtitle"),
            TopAppModel(imageNamed: "sun.max.circle.fill", title: "instagram title", subTitle: "instagram subtitle"),
            TopAppModel(imageNamed: "sunrise.circle.fill", title: "linkedin title", subTitle: "linkedin subtitle"),
            TopAppModel(imageNamed: "sun.min", title: "facebook title", subTitle: "facebook subtitle"),
            TopAppModel(imageNamed: "sun.max.circle.fill", title: "instagram title", subTitle: "instagram subtitle"),
            TopAppModel(imageNamed: "sunrise.circle.fill", title: "linkedin title", subTitle: "linkedin subtitle")
        ]
    }
}

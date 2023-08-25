//
//  ViewController.swift
//  CompositionalLayout
//
//  Created by kai jin on 2023/8/7.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    enum Section {
        case main
    }
    var dataSource:UICollectionViewDiffableDataSource<Section,Int>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //collectionView.register(UINib(nibName: "NumberCell", bundle: nil), forCellWithReuseIdentifier: "NumberCell")
        collectionView.backgroundColor = .black
        collectionView.collectionViewLayout = configLayout()
        configureDataSource()
    }
    
    
    func configLayout() -> UICollectionViewLayout {
        //Group width = 1.0，super view是section，section parent是collectionview layout所以它会占据整个屏幕的宽度，height = 0.2 *它的super view的宽度也是section
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func configLayout2() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(50), heightDimension: .fractionalHeight(1.0))
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem:item,count: 2)
        let spacing = CGFloat(100)
        group.interItemSpacing = .fixed(spacing)
//        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 10)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NumberCell", for: indexPath) as? NumberCell else {
                fatalError("cannot create new cell")
            }
            cell.title.text = itemIdentifier.description
            cell.backgroundColor = .red
            return cell
        })
        //initial data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(0..<94))
        dataSource.apply(snapshot,animatingDifferences: false)
    }
    
    
    
    


}


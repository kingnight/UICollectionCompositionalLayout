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
        case second
        case third
        case forth
        case fifth
    }
    var dataSource:UICollectionViewDiffableDataSource<Section,TopAppModel>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.register(UINib(nibName: "TopApp", bundle: nil), forCellWithReuseIdentifier: "TopApp")
        collectionView.backgroundColor = .black
        collectionView.collectionViewLayout = configLayout()
        //collectionVie
        configureDataSource()
    }
    
    private func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopApp.reuseIdentifier, for: indexPath) as? TopApp else {
                fatalError("cannot create new cell")
            }
            cell.appImageView.image = UIImage(systemName: itemIdentifier.imageNamed)
            cell.title.text = itemIdentifier.title
            cell.subTitle.text = itemIdentifier.subTitle
            if indexPath.row == 0{
                cell.backgroundColor = .red
            }
            else{
                cell.backgroundColor = .yellow
            }
            
            return cell
        })
        //initial data
        var snapshot = NSDiffableDataSourceSnapshot<Section, TopAppModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(TopAppModel.mock)
        snapshot.appendSections([.second])
        snapshot.appendItems(TopAppModel.mock2,toSection: .second)
//        snapshot.appendSections([.third])
//        snapshot.appendItems(TopAppModel.mock2,toSection: .third)
//        snapshot.appendSections([.forth])
//        snapshot.appendItems(TopAppModel.mock,toSection: .forth)
//        snapshot.appendSections([.fifth])
//        snapshot.appendItems(TopAppModel.mock,toSection: .fifth)
//        snapshot.appendItems(TopAppModel.mock,toSection: .fifth)
//        snapshot.appendItems(TopAppModel.mock,toSection: .fifth)
        dataSource.apply(snapshot,animatingDifferences: false)
    }
    
//    func createNestedGroupLayout() -> NSCollectionLayoutSection{
//        let leadingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(1.0)))
//        leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
//
//        let trailingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3)))
//        trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
//        let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1.0)), subitem: trailingItem, count: 2)
//
//        let nestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)), subitems: [leadingItem,trailingGroup])
//        let section = NSCollectionLayoutSection(group: nestedGroup)
//        return section
//    }
    //MARK: -  嵌套Collection View Nested Collection View
    func createNestedCollectionView() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(400))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .flexible(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous   //
        return section
    }
    //MARK: - grouppaging
    func createNestedGroupScrolling() -> NSCollectionLayoutSection{
        let leadingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(1.0)))
        leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let trailingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1.0)), subitem: trailingItem, count: 2)
        
        let containerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)), subitems: [leadingItem,trailingGroup])
        
        let section = NSCollectionLayoutSection(group: containerGroup)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        return section
    }
    
    func configLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            if sectionIndex == 0{
                return self.createNestedCollectionView()
            }
            else{
                return self.createNestedGroupScrolling()
            }
        }
        return layout
    }
}


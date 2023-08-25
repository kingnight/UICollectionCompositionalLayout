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
        case section2
        case section3
        case section4
    }
    var dataSource:UICollectionViewDiffableDataSource<Section,Int>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        collectionView.register(BadgeSupplementaryView.self, forSupplementaryViewOfKind: "badge-element-kind", withReuseIdentifier: BadgeSupplementaryView.reuseIdentifer)
        collectionView.register(TitleSupplementaryView.self, forSupplementaryViewOfKind: ElementKind.sectionHeader, withReuseIdentifier: TitleSupplementaryView.reuseIdentifer)
        collectionView.register(TitleSupplementaryView.self, forSupplementaryViewOfKind: ElementKind.sectionFooter, withReuseIdentifier: TitleSupplementaryView.reuseIdentifer)
        
        collectionView.register(BadgeSupplementaryView.self, forSupplementaryViewOfKind: BadgeSupplementaryView.reuseIdentifer, withReuseIdentifier: BadgeSupplementaryView.reuseIdentifer)
        collectionView.register(BadgeSupplementaryView1.self, forSupplementaryViewOfKind: BadgeSupplementaryView1.reuseIdentifer, withReuseIdentifier: BadgeSupplementaryView1.reuseIdentifer)
        
        collectionView.backgroundColor = .black
        collectionView.collectionViewLayout = configLayout()
        configureDataSource()
    }
    
    func configLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            if sectionIndex == 0 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item,count: 1)

                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
                section.orthogonalScrollingBehavior = .groupPaging
                return section
            }
            else{
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item,count: 10)

                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
                section.orthogonalScrollingBehavior = .continuous
                return section
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        config.scrollDirection = .horizontal //默认垂直
        layout.configuration = config
        return layout
    }
    
//MARK: - dataSource
    private func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NumberCell", for: indexPath) as? NumberCell else {
                fatalError("cannot create new cell")
            }
            cell.title.text = itemIdentifier.description
            cell.backgroundColor = .red
            return cell
        })
        
        dataSource.supplementaryViewProvider = { collectionView,kind,indexPath in
            //------------------
            if kind == BadgeSupplementaryView.reuseIdentifer {
                return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BadgeSupplementaryView.reuseIdentifer, for: indexPath) as! BadgeSupplementaryView
            }
            else if kind == BadgeSupplementaryView1.reuseIdentifer {
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BadgeSupplementaryView1.reuseIdentifer, for: indexPath) as! BadgeSupplementaryView1
                view.backgroundColor = .yellow
                return view
            }
            //------------------
            else if kind == ElementKind.sectionHeader{
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleSupplementaryView.reuseIdentifer, for: indexPath) as? TitleSupplementaryView else { return TitleSupplementaryView() }
                headerView.backgroundColor = .white
                headerView.label.text = "This is my header"
                return headerView
            }
            
            else if kind == ElementKind.sectionFooter{
                guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleSupplementaryView.reuseIdentifer, for: indexPath) as? TitleSupplementaryView else {
                    return TitleSupplementaryView()
                }
                footerView.backgroundColor = .yellow
                footerView.label.text = "This is my footer"
                return footerView
            }
            return nil
            
        }
        
        //initial data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main,.section2,.section3,.section4])
        snapshot.appendItems(Array(0..<5),toSection: .main)
        snapshot.appendItems(Array(6..<10),toSection: .section2)
//        snapshot.appendItems(Array(31..<55),toSection: .section3)
//        snapshot.appendItems(Array(56..<80),toSection: .section4)
        dataSource.apply(snapshot,animatingDifferences: false)
    }
    


}


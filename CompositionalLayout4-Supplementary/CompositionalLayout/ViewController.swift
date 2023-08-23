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
        //1
        collectionView.register(BadgeSupplementaryView.self, forSupplementaryViewOfKind: ElementKind.badge, withReuseIdentifier: BadgeSupplementaryView.reuseIdentifer)
        
        collectionView.register(TitleSupplementaryView.self, forSupplementaryViewOfKind: ElementKind.sectionHeader, withReuseIdentifier: TitleSupplementaryView.reuseIdentifer)
        collectionView.register(TitleSupplementaryView.self, forSupplementaryViewOfKind: ElementKind.sectionFooter, withReuseIdentifier: TitleSupplementaryView.reuseIdentifer)
        //3
        collectionView.register(BadgeSupplementaryView.self, forSupplementaryViewOfKind: BadgeSupplementaryView.reuseIdentifer, withReuseIdentifier: BadgeSupplementaryView.reuseIdentifer)
        collectionView.register(BadgeSupplementaryView1.self, forSupplementaryViewOfKind: BadgeSupplementaryView1.reuseIdentifer, withReuseIdentifier: BadgeSupplementaryView1.reuseIdentifer)
        
        collectionView.backgroundColor = .black
        collectionView.collectionViewLayout = configLayout()
        configureDataSource()
    }
    
    //1 右上角外移
//    func configLayout() -> UICollectionViewLayout {
//        let badgeAnchor = NSCollectionLayoutAnchor(edges: [.top,.trailing],fractionalOffset: CGPoint(x: 0.3, y: -0.3))
//        let badgeSize = NSCollectionLayoutSize(widthDimension: .absolute(20), heightDimension: .absolute(20))
//        let badge = NSCollectionLayoutSupplementaryItem(layoutSize: badgeSize, elementKind: "badge-element-kind", containerAnchor: badgeAnchor)
//
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1.0))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize,supplementaryItems: [badge])
//        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
//
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.2))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//
//        let section = NSCollectionLayoutSection(group: group)
//        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
//
//        let layout = UICollectionViewCompositionalLayout(section: section)
//        return layout
//    }
    
    //2 左上角内顶点
//    func configLayout() -> UICollectionViewLayout {
//        //改动 edge 和 fractionalOffset，从右侧变到左侧
//        let badgeAnchor = NSCollectionLayoutAnchor(edges: [.top,.leading],fractionalOffset: CGPoint(x: 0, y: 0))
//        let badgeSize = NSCollectionLayoutSize(widthDimension: .absolute(20), heightDimension: .absolute(20))
//        let badge = NSCollectionLayoutSupplementaryItem(layoutSize: badgeSize, elementKind: "badge-element-kind", containerAnchor: badgeAnchor)
//
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1.0))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize,supplementaryItems: [badge])
//        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
//
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.2))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//
//        let section = NSCollectionLayoutSection(group: group)
//        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
//
//        let layout = UICollectionViewCompositionalLayout(section: section)
//        return layout
//    }
   
    
        //3 页眉&页脚
//        func configLayout() -> UICollectionViewLayout {
//            let badgeAnchor = NSCollectionLayoutAnchor(edges: [.top,.trailing],fractionalOffset: CGPoint(x: 0.3, y: -0.3))
//            let badgeSize = NSCollectionLayoutSize(widthDimension: .absolute(20), heightDimension: .absolute(20))
//            let badge = NSCollectionLayoutSupplementaryItem(layoutSize: badgeSize, elementKind: ElementKind.badge, containerAnchor: badgeAnchor)
//
//            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1.0))
//            let item = NSCollectionLayoutItem(layoutSize: itemSize,supplementaryItems: [badge])
//            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
//
//            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.2))
//            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//
//            let section = NSCollectionLayoutSection(group: group)
//            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
//            //新=================================
//            let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
//            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: ElementKind.sectionHeader, alignment: .top)
//            sectionHeader.pinToVisibleBounds = true
//            let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize,elementKind: ElementKind.sectionFooter,alignment: .bottom)
//            sectionFooter.pinToVisibleBounds = true
//            section.boundarySupplementaryItems = [sectionHeader,sectionFooter]
//            //新=================================
//            let layout = UICollectionViewCompositionalLayout(section: section)
//            return layout
//        }
    
    //4 多Badge
    func configLayout() -> UICollectionViewLayout {
        let badgeAnchor = NSCollectionLayoutAnchor(edges: [.top,.trailing],fractionalOffset: CGPoint(x: 0.3, y: -0.3))
        let badgeSize = NSCollectionLayoutSize(widthDimension: .absolute(20), heightDimension: .absolute(20))
        //新=================================
        let badge1 = NSCollectionLayoutSupplementaryItem(layoutSize: badgeSize, elementKind: BadgeSupplementaryView.reuseIdentifer, containerAnchor: badgeAnchor)
        badge1.zIndex = 2

        let badge2Anchor = NSCollectionLayoutAnchor(edges: [.top,.leading],fractionalOffset: CGPoint(x: -0.3, y: -0.3))
        let badge2 = NSCollectionLayoutSupplementaryItem(layoutSize: badgeSize, elementKind: BadgeSupplementaryView1.reuseIdentifer, containerAnchor: badge2Anchor)
        //badge2.zIndex = 2

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize,supplementaryItems: [badge1,badge2])
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        //新=================================
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)

        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: ElementKind.sectionHeader, alignment: .top)
        sectionHeader.pinToVisibleBounds = true
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize,elementKind: ElementKind.sectionFooter,alignment: .bottom)
        sectionFooter.pinToVisibleBounds = true
        section.boundarySupplementaryItems = [sectionHeader,sectionFooter]

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
//MARK: - dataSource
    //1
//    private func configureDataSource(){
//        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NumberCell", for: indexPath) as? NumberCell else {
//                fatalError("cannot create new cell")
//            }
//            cell.title.text = itemIdentifier.description
//            cell.backgroundColor = .red
//            return cell
//        })
//
//        dataSource.supplementaryViewProvider = { collectionView,kind,indexPath in
//            if kind == "badge-element-kind" && indexPath.section == 0 {
//                return collectionView.dequeueReusableSupplementaryView(ofKind: "badge-element-kind", withReuseIdentifier: BadgeSupplementaryView.reuseIdentifer, for: indexPath) as! BadgeSupplementaryView
//            }
//            else{
//                return nil
//            }
//
//        }
//
//        //initial data
//        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
//        snapshot.appendSections([.main])
//        snapshot.appendItems(Array(0..<94))
//        dataSource.apply(snapshot,animatingDifferences: false)
//    }
    
    //3
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
            if kind == ElementKind.badge {
                return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BadgeSupplementaryView.reuseIdentifer, for: indexPath) as! BadgeSupplementaryView
            }
            else if kind == BadgeSupplementaryView.reuseIdentifer {
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
        snapshot.appendItems(Array(0..<10),toSection: .main)
        snapshot.appendItems(Array(11..<30),toSection: .section2)
        snapshot.appendItems(Array(31..<55),toSection: .section3)
        snapshot.appendItems(Array(56..<80),toSection: .section4)
        dataSource.apply(snapshot,animatingDifferences: false)
    }

}


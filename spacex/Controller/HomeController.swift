//
//  HomeController.swift
//  spacex
//
//  Created by Martin on 05/07/2021.
//

import UIKit

class HomeController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var launches: [Launch] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.collectionView.register(UpcomingCell.nib, forCellWithReuseIdentifier: UpcomingCell.identifier)
        self.collectionView.register(OldCell.nib, forCellWithReuseIdentifier: OldCell.identifier)
        self.collectionView.register(SectionHeader.nib,
                                     forSupplementaryViewOfKind: "SectionHeaderKind",
                                     withReuseIdentifier: SectionHeader.identifier)
        getLaunches()
        self.collectionView.collectionViewLayout = self.createLayout()
       // createDataSource()
        self.collectionView.contentInset.top = 150
    }
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, Launch> = {
        let dataSource = UICollectionViewDiffableDataSource<Section, Launch>(collectionView: self.collectionView) { collectionView, indexPath, item in
            
            let actualSection = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            
            switch actualSection {
            
            case .upcoming:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingCell.identifier,
                                                              for: indexPath) as? UpcomingCell
                cell?.configure(with: item)
                return cell
                
            case .past:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OldCell.identifier,
                                                              for: indexPath) as? OldCell
                cell?.configure(with: item)
                return cell
            }
        }
        dataSource.supplementaryViewProvider = self.supplementary(collectionView:kind:indexPath:)
        return dataSource
    }()
    
    private func createLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout(sectionProvider: self.createSection(index: environment:))
    }
    
    private func createSection(index: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        
        let actualSection = self.dataSource.snapshot().sectionIdentifiers[index]
        
        var section: NSCollectionLayoutSection!
        
            switch actualSection {
            case .upcoming:
                section = self.upcomingLayout()
                
            case .past:
                section = self.oldLayout()
            }
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(25))
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: "SectionHeaderKind",
                                                                        alignment: .top)
        
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    private func oldLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 12.5, bottom: 11, trailing: 10.5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(195))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 5
        
        return section
    }
    
    private func upcomingLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 12.5, bottom: 11, trailing: 10.5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.75), heightDimension: .estimated(200))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .continuous
        
        section.interGroupSpacing = 5
        
        return section
    }
    
    private func supplementary(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: SectionHeader.identifier,
                                                                     for: indexPath)
        
        let actualSection = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
        
        if let test = header as? SectionHeader {
            
            test.configure(with: actualSection)
        }
        
        return header
    }
    
    private func reloadData(pastLaunches: [Launch], upcomingLaunches: [Launch]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Launch>()
        snapshot.appendSections(Section.allCases)
        
        snapshot.appendItems(upcomingLaunches, toSection: .upcoming)
        snapshot.appendItems(pastLaunches, toSection: .past)
        
        dataSource.apply(snapshot)
    }
    
    private func update(launch: [Launch]) {
        var pastLaunches: [Launch] = []
        var upcomingLaunches: [Launch] = []
        
        for eachLaunch in launch {
            switch eachLaunch.upcoming {
            case true:
                upcomingLaunches.append(eachLaunch)
                
            default:
                pastLaunches.append(eachLaunch)
            }
        }
        
        upcomingLaunches.sort {
            $0.dateUnix < $1.dateUnix
        }
        
        pastLaunches.sort {
            $0.dateUnix > $1.dateUnix
        }
        reloadData(pastLaunches: pastLaunches, upcomingLaunches: upcomingLaunches)
    }
    
    @objc
    private func getLaunches() {
        LaunchService.shared.getLaunch { success, launch
            in
            if success, let launch = launch {
                self.update(launch: launch)
            }
        }
    }
}

extension HomeController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}

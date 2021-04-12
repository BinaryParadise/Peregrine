//
//  SkillPointsViewController.swift
//  BeSwifter_Example
//
//  Created by Rake Yang on 2021/3/4.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import SwifterSwift
import Peregrine
import SnapKit

/// 技能点入口
class FPViewController: UIViewController {
    private let collectView = UICollectionView(frame: .zero, collectionViewLayout: {
        let flowLayout = WrapperFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 4, left: 16, bottom: 8, right: 16)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 12
        flowLayout.estimatedItemSize = CGSize(width: (UIScreen.main.bounds.width-16*2-12)/2, height: 30)
        return flowLayout
    }())
    
    var routes: [[RouteNode]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectView.backgroundColor = view.backgroundColor
        collectView.dataSource = self
        collectView.delegate = self
        view.addSubview(collectView)
        collectView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        collectView.register(supplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withClass: RouteSectionView.self)
        collectView.register(cellWithClass: RouteItemCell.self)
        
        let routeMap = RouteManager.shared.routeMap
        routeMap.keys.sorted(by: { (k1, k2) -> Bool in
            return k1.compare(k2) == .orderedAscending
        }).forEach { (rkey) in
            if let item = routeMap[rkey] {
                let arr = item.childs.values.sorted { (node1, node2) -> Bool in
                    return node1.url.absoluteString.compare(node2.url.absoluteString) == .orderedAscending
                }
                if arr.count > 0 {
                    routes.append(arr)
                }
            }
        }
    }
}

extension FPViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return routes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return routes[safe: section]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: RouteItemCell.self, for: indexPath)
        if let node = routes[safe: indexPath.section] {
            cell.titleLabel.text = node[safe: indexPath.row]!.url.path
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 60, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withClass: RouteSectionView.self, for: indexPath)
            if let node = routes[safe: indexPath.section]![safe: indexPath.row] {
                sectionView.titleLabel.text = "\(node.url.scheme!)://\(node.url.host!)"
            }
            return sectionView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let node = routes[safe: indexPath.section]![safe: indexPath.row] {
            RouteManager.openURL(node.url.absoluteString) { (ret, data) in
                print("\(#function) \(ret),\(data)")
            }
        }
    }
    
}

class RouteSectionView: UICollectionReusableView {
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class RouteItemCell: UICollectionViewCell {
    let titleLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 5
        layer.masksToBounds = true
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.systemPink.cgColor
        
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = UIColor(hex: 0x333333)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 4, left: 6, bottom: 4, right: 6))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  UICollectionViewExtension.swift
//
//  Created by Pramod Kumar on 04/04/18.
//  Copyright © 2018 Pramod Kumar. All rights reserved.
//

import Foundation
import UIKit

//MARK:- UICollectionView Extension
extension UICollectionView {
    
    func registerCell(nibName:String, bundle:Bundle? = nil, forCellWithReuseIdentifier:String? = nil){

        let cellWithReuseIdentifier = forCellWithReuseIdentifier ?? nibName
         self.register(UINib(nibName: nibName , bundle: bundle), forCellWithReuseIdentifier: cellWithReuseIdentifier)
    }
    
    func cell(forItem: AnyObject) -> UICollectionViewCell? {
        if let indexPath = self.indexPath(forItem: forItem) {
            return self.cellForItem(at: indexPath)
        }
        return nil
    }
    
    func indexPath(forItem: AnyObject) -> IndexPath? {
        let itemPosition: CGPoint = forItem.convert(CGPoint.zero, to: self)
        return self.indexPathForItem(at: itemPosition)
    }
    
    func indexPathsForElementsInRect(rect: CGRect) -> NSArray?{
        let allLayoutAttributes = self.collectionViewLayout.layoutAttributesForElements(in: rect)
        if let layoutAttributes = allLayoutAttributes, layoutAttributes.count > 0{
            let indexPaths = NSMutableArray(capacity: layoutAttributes.count)
            for layoutAttribute in layoutAttributes{
                let indexPath = layoutAttribute.indexPath
                indexPaths.add(indexPath)
            }
            return indexPaths
        }
        else{
            return nil
        }
    }
    
    func isItemPresentAt(index: IndexPath) -> Bool {
        if index.section < self.numberOfSections {
            if index.item < self.numberOfItems(inSection: index.section) {
                return true
            }
        }
        return false
    }
    
    func isSectionPresentAt(section: Int) -> Bool {
        if section < self.numberOfSections {
            return true
        }
        return false
    }
    
    func reloadItems(at: IndexPath) {
        if self.isItemPresentAt(index: at) {
            self.reloadItems(at: [at])
        }
        else {
            self.reloadData()
        }
    }
    
    func reloadSection(section: Int) {
        if self.isSectionPresentAt(section: section) {
            self.reloadSections(IndexSet(integer: section))
        }
        else {
            self.reloadData()
        }
    }
    
    ///pull to refresh
    func enablePullToRefresh(target: UIViewController, selector: Selector, tintColor: UIColor? = nil){
        
        let refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = .black
        refreshControl.addTarget(target, action: selector, for: UIControl.Event.valueChanged)
        if let tColor = tintColor{
            refreshControl.tintColor = tColor
        }
        self.alwaysBounceVertical = true
        self.addSubview(refreshControl)
    }
    
    func endRefreshing(){
        
        for view in self.subviews{
            
            if let refreshControl = view as? UIRefreshControl{
                refreshControl.endRefreshing()
                break
            }
        }
    }
    
    func selectedCell(forCell cell: UICollectionViewCell) -> IndexPath? {
        let cellPosition: CGPoint = cell.convert(CGPoint.zero, to: self)
        return self.indexPathForItem(at: cellPosition)
    }
    
}

extension UICollectionViewCell {
    class var reusableIdentifier: String {
        return "\(self)"
    }
    
    var indexPath: IndexPath? {
        if let tblVw = self.superview as? UICollectionView {
            return tblVw.indexPath(for: self)
        }
        return nil
    }
}

//
//  WHYCollctionView.swift
//  Demo
//
//  Created by wanghongyun on 2016/12/6.
//  Copyright © 2016年 wanghongyun. All rights reserved.
//

import UIKit

// MARK: WHYCollectionDataSource
protocol WHYCollectionViewDataSource : NSObjectProtocol {
    
    func numberOfSections(in collectionView: WHYCollectionView) -> Int
    
    func collectionView(_ collectionView: WHYCollectionView, numberOfItemsInSection section: Int) -> Int
    
    func collectionView(_ collectionView: WHYCollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    
}

// MARK: WHYCollectionDelegate
protocol WHYCollectionViewDelegate : NSObjectProtocol {
    
}


class WHYCollectionView: UIScrollView {

    // MARK: open var
    open weak var collectionDataSource: WHYCollectionViewDataSource?
    
    open weak var collectionDelegate: WHYCollectionViewDelegate?
    
    open var collectionHeaderView: UIView?
    
    open var collectionFooterView: UIView?
    
    open var flowLayout: UICollectionViewFlowLayout
    
    // MARK: private var
    private var collectionView: UICollectionView
    
    // MARK: init func
    init(withFlowLayout flowLayout: UICollectionViewFlowLayout, frame: CGRect) {
        
        self.flowLayout = flowLayout
        collectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: open func
    func reloadData() {
        
    }

}

extension WHYCollectionView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        guard let dataSource = collectionDataSource else { return 0 }
        
        return dataSource.numberOfSections(in: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let dataSource = collectionDataSource else { return 0 }
        
        return dataSource.collectionView(self, numberOfItemsInSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let dataSource = collectionDataSource else { return UICollectionViewCell.init() }
        
        return dataSource.collectionView(self, cellForItemAt: indexPath)
    }
    
}

extension WHYCollectionView: UICollectionViewDelegate {
    
}

extension WHYCollectionViewDataSource {
    
    func numberOfSections(in collectionView: WHYCollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: WHYCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0;
    }
    
    func collectionView(_ collectionView: WHYCollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell.init()
    }
    
}

extension WHYCollectionViewDelegate {
    
}

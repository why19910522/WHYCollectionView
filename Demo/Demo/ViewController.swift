//
//  ViewController.swift
//  Demo
//
//  Created by wanghongyun on 2016/12/6.
//  Copyright © 2016年 wanghongyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let cellId = "test"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        
        let flowLayout                     = UICollectionViewFlowLayout()
        flowLayout.itemSize                = CGSize(width: 100, height: 100)
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing      = 10
//        flowLayout.scrollDirection         = .horizontal
        
        let collectionView = WHYCollectionView(with: view.bounds, flowLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.collectionDataSource = self
        collectionView.collectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
//        collectionView.scrollDirection = .horizontal
        
        view.addSubview(collectionView)
        
        collectionView.register(cellClass:UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: cellId)
        
        let headerView = UIView(frame: CGRect(x: 110, y: 0, width: 60, height: 60))
        headerView.backgroundColor = .red
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        footerView.backgroundColor = .green
        
        collectionView.collectionHeaderView = headerView
        collectionView.collectionFooterView = footerView
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .cyan
        
        return cell;
    }
    
}



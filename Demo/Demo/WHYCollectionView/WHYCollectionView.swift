//
//  WHYCollctionView.swift
//  Demo
//
//  Created by wanghongyun on 2016/12/6.
//  Copyright © 2016年 wanghongyun. All rights reserved.
//

import UIKit

enum WHYCollectionViewScrollDirection: Int {
    case vertical
    case horizontal
    
    init() {
        self = .vertical
    }
}

class WHYCollectionView: UIScrollView {

    // MARK: open var
    open weak var collectionDelegate: UICollectionViewDelegate? {
        didSet {
            collectionView.delegate = collectionDelegate
        }
    }
    
    open weak var collectionDataSource: UICollectionViewDataSource? {
        didSet {
            collectionView.dataSource = collectionDataSource
        }
    }
    
    open var collectionHeaderView: UIView? {
        didSet {
            oldValue?.removeFromSuperview()
            
            if let headerView = collectionHeaderView {
                addSubview(headerView)
            }
            
            updateCollectionFrame()
        }
    }
    
    open var collectionFooterView: UIView? {
        didSet {
            oldValue?.removeFromSuperview()
            
            if let footerView = collectionFooterView {
                addSubview(footerView)
            }
            
            updateCollectionFrame()
        }
    }
    
    /// 设置滚动方向时, 需要同时设置flowLayout里的滚动方向, 否则会显示错误
    open var scrollDirection: WHYCollectionViewScrollDirection
    
    open var flowLayout: UICollectionViewLayout {
        didSet {
            collectionView.collectionViewLayout = flowLayout
        }
    }
    
    open var collectionView: UICollectionView
    
    open override var backgroundColor: UIColor? {
        didSet {
            collectionView.backgroundColor = backgroundColor
        }
    }
    
    open var collectionInset: UIEdgeInsets? {
        didSet {
            if let inset = collectionInset {
                collectionView.contentInset = inset;
                updateCollectionFrame()
            }
        }
    }
    
    // MARK: init func
    init(with frame: CGRect = .zero,
         flowLayout: UICollectionViewLayout = UICollectionViewFlowLayout(),
          direction: WHYCollectionViewScrollDirection = .vertical) {
        
        scrollDirection = direction
        collectionView  = UICollectionView(frame: CGRect(origin: .zero, size: frame.size), collectionViewLayout: flowLayout)
        self.flowLayout = flowLayout
        
        super.init(frame: frame)
        
        setupCollectionView()
        
    }
    
    convenience init() {
        self.init(with: .zero);
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    // MARK: open func
    func reloadData() {
        updateCollectionFrame()
        collectionView.reloadData()
    }
    
    open func register(cellClass: Swift.AnyClass?, forCellWithReuseIdentifier identifier: String) {
        collectionView.register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    open func register(cellNib: UINib?, forCellWithReuseIdentifier identifier: String) {
        collectionView.register(cellNib, forCellWithReuseIdentifier: identifier)
    }
    
    open func register(viewClass: Swift.AnyClass?, forSupplementaryViewOfKind elementKind: String, withReuseIdentifier identifier: String) {
        collectionView.register(viewClass, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: identifier)
    }

    open func register(viewNib: UINib?, forSupplementaryViewOfKind kind: String, withReuseIdentifier identifier: String) {
        collectionView.register(viewNib, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
    }
    
    // MARK: private func
    private func setupCollectionView() {
        addSubview(collectionView)
        collectionView.isScrollEnabled = false
    }
    
    private func updateCollectionFrame() {
        switch scrollDirection {
        case .horizontal:
            updateHorizontalFrame()
        default:
            updateVerticalFrame()
        }
    }
    
    private func updateHorizontalFrame() {
        
        var scrollWidth     = collectionView.frame.size.width
        var collectionFrame = collectionView.frame
        let inset           = collectionInset ?? UIEdgeInsetsMake(0, 0, 0, 0)
        
        collectionFrame.size.width  = collectionView.collectionViewLayout.collectionViewContentSize.width
        collectionFrame.size.width += (inset.left + inset.right)
        
        if let headerView = collectionHeaderView {
            scrollWidth             += headerView.frame.size.width
            headerView.frame         = CGRect(x: 0, y: 0, width: headerView.bounds.size.width, height: bounds.size.height)
            collectionFrame.origin.x = headerView.frame.size.width
        }
        
        if let footerView = collectionFooterView {
            scrollWidth     += footerView.frame.size.width
            footerView.frame = CGRect(x: collectionFrame.maxX, y: 0, width: footerView.bounds.size.width, height: bounds.size.height)
        }
        
        collectionView.frame = collectionFrame
        contentSize          = CGSize(width: scrollWidth, height: 0)
    }
    
    private func updateVerticalFrame() {
        
        var scrollHeight    = collectionView.frame.size.height
        var collectionFrame = collectionView.frame
        let inset           = collectionInset ?? UIEdgeInsetsMake(0, 0, 0, 0)
        
        collectionFrame.size.height  = collectionView.collectionViewLayout.collectionViewContentSize.height
        collectionFrame.size.height += (inset.bottom + inset.top)
        
        if let headerView = collectionHeaderView {
            scrollHeight            += headerView.frame.size.height
            headerView.frame         = CGRect(x: 0, y: 0, width: bounds.size.width, height: headerView.bounds.size.height)
            collectionFrame.origin.y = headerView.frame.size.height
        }
        
        if let footerView = collectionFooterView {
            scrollHeight    += footerView.frame.size.height
            footerView.frame = CGRect(x: 0, y: collectionFrame.maxY, width: bounds.size.width, height: footerView.bounds.size.height)
        }
        
        collectionView.frame = collectionFrame
        contentSize          = CGSize(width: 0, height: scrollHeight)
    }
}

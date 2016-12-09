# WHYCollectionView
[![Language](https://img.shields.io/badge/language-Swift%203.0-orange.svg)](https://swift.org/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/cyanzhong/xTextHandler/blob/master/LICENSE)

为 UICollectionView 添加 Header/FooterView

## 使用方法
基本与 UICollectionView 的使用方法一致

添加 CollectionHeaderView 或者 CollectionFooterView 的方法与 UITableView 的方式一致

scrollDirection属性在设置时需要同时设置flowLayout里的scrollDirection, 否则会显示错误

collectionInset属性设置的是 WHYCollectionView 中 UICollectionView  的 contentInset , 并非 WHYCollectionView 自身的内边距

##示例代码
```
class ViewController: UIViewController {
    
    let cellId = "test"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flowLayout                     = UICollectionViewFlowLayout()
        flowLayout.itemSize                = CGSize(width: 100, height: 100)
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing      = 10
        flowLayout.scrollDirection         = .horizontal
        
        let collectionView = WHYCollectionView(with: view.bounds, layout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.collectionDataSource = self
        collectionView.collectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        collectionView.scrollDirection = .horizontal
        
        view.addSubview(collectionView)
        
        collectionView.register(cellClass:UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: cellId)
        
        let headerView = UIView(frame: CGRect(x: 110, y: 0, width: 60, height: 60))
        headerView.backgroundColor = .red
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        footerView.backgroundColor = .green
        
        collectionView.collectionHeaderView = headerView
        collectionView.collectionFooterView = footerView
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
```
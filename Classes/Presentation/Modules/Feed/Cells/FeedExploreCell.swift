import UIKit

final class FeedExploreCell: UICollectionViewCell {
    
    lazy var feedExploreCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 14
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .black
        collectionView.showsVerticalScrollIndicator = false
        collectionView.registerCellClass(FeedExploreCollectionCell.self)
        return collectionView
    }()
    
    var cellModelResolver: (() -> [FeedExploreCellModel])?
    var onSelect: ((IndexPath) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(feedExploreCollectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("ERROR: init(coder): FeedExploreCell")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        feedExploreCollectionView.configureFrame {
            $0.edges(insets: .zero)
        }
    }
    
    func update() {
        feedExploreCollectionView.reloadData()
    }
}

// MARK: -  UICollectionViewDataSource

extension FeedExploreCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return cellModelResolver?().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cellModel = cellModelResolver?()[safe: indexPath.row] else {
            return UICollectionViewCell()
        }
        
        let cell: FeedExploreCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.categoryNameLabel.text = cellModelResolver?()[safe: indexPath.row]?.title
        cell.layoutSubviews()
        cell.imageView.nuke_setImage(with: cellModel.imageURL)

        return cell
    }
}

// MARK: -  UICollectionViewDelegate

extension FeedExploreCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onSelect?(indexPath)
    }
}

// MARK: -  UICollectionViewDelegateFlowLayout

extension FeedExploreCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return collectionView.bounds.size
    }
}


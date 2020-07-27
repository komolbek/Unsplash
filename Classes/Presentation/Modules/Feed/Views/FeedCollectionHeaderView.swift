import UIKit
import Framezilla

final class FeedCollectionHeaderView: UICollectionReusableView {
    
    private enum Constants {
        static let insets:UIEdgeInsets = .init(top: 10, left: 20, bottom: 15, right: 10)
    }
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.courierWithSize_18
        label.textColor = .white
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("ERROR: init(coder): FeedCollectionHeaderView")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.configureFrame {
            $0.left(inset: Constants.insets.left)
            $0.centerY()
            $0.sizeToFit()
        }
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var fittingSize: CGSize = .zero
        fittingSize.height += Constants.insets.top + Constants.insets.bottom
        fittingSize.height += titleLabel.sizeThatFits(size).height
        
        return fittingSize
    }
}



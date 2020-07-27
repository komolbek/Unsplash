import UIKit
import Framezilla

final class FeedExploreCollectionCell: UICollectionViewCell {
    
    private enum Constants {
        static let insets: UIEdgeInsets = .init(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    private let gradient = Gradient(alpha: 0.35, coverArea: .center)
    
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private(set) lazy var categoryNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.courierWithSize_18
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.addSubview(gradient)
        contentView.addSubviews(imageView, categoryNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("ERROR: init(coder): FeedExploreCollectionCell")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.configureFrame {
            $0.edges(insets: Constants.insets)
            $0.cornerRadius(10)
        }
        gradient.configureFrame {
            $0.edges(insets: .zero)
        }
        categoryNameLabel.configureFrame {
            $0.center(to: imageView)
            $0.sizeToFit()
        }
    }
}

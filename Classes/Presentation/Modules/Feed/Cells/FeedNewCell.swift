import UIKit
import Framezilla

final class FeedNewCell: UICollectionViewCell {
    
    private enum Constants {
        static let insets: UIEdgeInsets = .init(top: 15, left: 15, bottom: 15, right: 15)
    }
    
    private let gradient = Gradient(alpha: 0.6, coverArea: .bottom)
    
    private(set) lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.courierWithSize_16
        label.textColor = .white
        
        return label
    }()
    
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private(set) lazy var authorNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        
        return label
    }()
    
    private(set) lazy var createdDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.courierWithSize_14
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.addSubviews(gradient, likesLabel, authorNameLabel, createdDateLabel)
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("ERROR: init(coder): FeedNewCell")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.configureFrame {
            $0.edges(insets: .zero)
        }
        gradient.configureFrame {
            $0.edges(insets: .zero)
        }
        authorNameLabel.configureFrame {
            $0.sizeToFit()
            $0.left(inset: Constants.insets.left)
            $0.bottom(to: createdDateLabel.nui_top, inset: 5)
        }
        createdDateLabel.configureFrame {
            $0.sizeToFit()
            $0.left(inset: Constants.insets.right)
            $0.bottom(inset: Constants.insets.bottom)
        }
        likesLabel.configureFrame {
            $0.right(inset: Constants.insets.right).bottom(inset: Constants.insets.bottom)
            $0.sizeToFit()
        }
    }
    
    func setupLikesLabel(using text: String) {
        likesLabel.setupAttributedText(using: text)
    }
}


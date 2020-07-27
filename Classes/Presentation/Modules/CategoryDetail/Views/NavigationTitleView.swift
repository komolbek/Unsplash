//
//  Created by Komolbek Ibragimov on 14/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import UIKit
import Framezilla

final class NavitgationTitleView: UIView {
    
    private enum Constants {
        static let insets: UIEdgeInsets = .init(top: 5, left: 0, bottom: 5, right: 0)
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.courierWithSize_16
        label.textColor = .white
        
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.courierWithSize_12
        label.textColor = .gray
        
        return label
    }()
    
    private var titleViewHeigh: CGFloat {
        return UINavigationController().navigationBar.bounds.height
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews(titleLabel, subTitleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureFrame {
            $0.width(bounds.width)
            $0.height(titleViewHeigh)
        }
        titleLabel.configureFrame {
            $0.top(inset: Constants.insets.top)
            $0.centerX()
            $0.sizeToFit()
        }
        subTitleLabel.configureFrame {
            $0.bottom(inset: Constants.insets.bottom)
            $0.centerX()
            $0.sizeToFit()
        }
    }
    
    func set(_ titleText: String, and subTitleText: String) {
        titleLabel.text = titleText
        subTitleLabel.text = subTitleText
    }
}

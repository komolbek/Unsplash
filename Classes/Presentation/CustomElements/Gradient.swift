//
//  Created by Komolbek Ibragimov on 15/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import UIKit.UIView

final class Gradient: UIView {
    
    enum CoverArea {
        case bottom, center
    }
    
    private var colors: [CGColor] = [
        UIColor(myRed: 58, myGreen: 123, myBlue: 213).cgColor,
        UIColor(myRed: 100, myGreen: 228, myBlue: 255).cgColor
    ]
    
    init(frame: CGRect = .zero, alpha: CGFloat = 1.0, coverArea: CoverArea) {
        super.init(frame: frame)
        
        if let layer = self.layer as? CAGradientLayer {
            layer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
            
            switch coverArea {
            case .bottom:
                layer.locations = [0.5, 1.0]
            case .center:
                layer.locations = [0.0, 0.5]
            }
        }
        
        self.alpha = alpha
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

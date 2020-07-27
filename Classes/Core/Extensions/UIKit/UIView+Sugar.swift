//
//  Created by Komolbek Ibragimov on 07/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import UIKit.UIView

extension UIView {
    
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach(self.addSubview)
    }
    
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(self.addSubview)
    }
}

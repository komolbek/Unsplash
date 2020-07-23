//
//  Created by Komolbek Ibragimov on 15/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import UIKit.NSTextAttachment

extension NSTextAttachment {
    
    func setHeight(of height: CGFloat) {
        guard let image = image else {
            return
        }
        
        let ratio = image.size.width / image.size.height
        bounds = CGRect(x: bounds.origin.x,
                        y: bounds.origin.y - 9,
                        width: ratio * height,
                        height: height)
    }
}

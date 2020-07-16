//
//  Created by Komolbek Ibragimov on 15/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import UIKit.UIColor

extension UIColor {
    
    convenience init(myRed: Int, myGreen: Int, myBlue: Int) {
        self.init(red: CGFloat(myRed)/255,
                  green: CGFloat(myGreen)/255,
                  blue: CGFloat(myBlue)/255,
                  alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(red: CGFloat((rgb >> 16) & 0xFF),
                  green: CGFloat((rgb >> 8) & 0xFF),
                  blue: CGFloat(rgb & 0xFF),
                  alpha: 1.0)
    }
}

//
//  Created by Komolbek Ibragimov on 14/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import UIKit.UIImage

extension UIImage {

    //MARK: - CategoryDetailFeedModule
    
    enum CategoryDetail {
        static let navLeftButtonImage = imageNamed("back_icon")
    }
    
    //MARK: MainFeedModule
    
    enum MainFeed {
        static let likeLabelIcon = imageNamed("like_icon")
    }
}

extension UIImage {
    
    private static func imageNamed(_ name: String) -> UIImage {
        return UIImage(named: name) ?? UIImage()
    }
}


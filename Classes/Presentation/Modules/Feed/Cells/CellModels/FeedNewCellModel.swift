//
//  Created by Komolbek Ibragimov on 07/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import UIKit

final class FeedNewCellModel: FeedCellModel {
    
    let userName: String?
    let date: String?
    let width: CGFloat
    let height: CGFloat
    let likes: String
    
    init(userName: String?, date: String?, imageURL: URL?, width: CGFloat, height: CGFloat, likes: String) {
        self.userName = userName
        self.date = date
        self.width = width
        self.height = height
        self.likes = likes
        
        super.init(imageURL: imageURL)
    }
}

extension FeedNewCellModel {
    
    static func == (lhs: FeedNewCellModel, rhs: FeedNewCellModel) -> Bool {
        return lhs.userName == rhs.userName &&
            lhs.imageURL == rhs.imageURL &&
            lhs.date == rhs.date &&
            lhs.width == rhs.width &&
            lhs.height == rhs.height
    }
}



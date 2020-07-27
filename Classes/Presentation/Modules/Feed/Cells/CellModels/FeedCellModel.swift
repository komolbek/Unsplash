//  Created by Komolbek Ibragimov on 07/07/2020
//  Copyright © 2020 HiQo. All rights reserved.

import Foundation

class FeedCellModel {
    
    let imageURL: URL?
    
    init(imageURL: URL?) {
        self.imageURL = imageURL
    }
}

extension FeedCellModel: Equatable {
    
    static func == (lhs: FeedCellModel, rhs: FeedCellModel) -> Bool {
        return lhs.imageURL == rhs.imageURL
    }
}



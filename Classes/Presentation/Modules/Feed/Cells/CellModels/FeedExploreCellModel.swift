//
//  Created by Komolbek Ibragimov on 07/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import Foundation

final class FeedExploreCellModel: FeedCellModel {
    
    let title: String?
    
    init(title: String?, imageURL: URL?) {
        self.title = title
        super.init(imageURL: imageURL)
    }
}

extension FeedExploreCellModel {
    
    static func == (lhs: FeedExploreCellModel, rhs: FeedExploreCellModel) -> Bool {
        return lhs.title == rhs.title &&
            lhs.imageURL == rhs.imageURL
    }
}



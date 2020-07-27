//
//  Created by Komolbek Ibragimov on 07/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import Foundation

final class FeedSectionModel {
    
    let title: String?
    let cellModels: [FeedCellModel]?
    
    init(title: String?, cellModels: [FeedCellModel]?) {
        self.title = title
        self.cellModels = cellModels
    }
}

extension FeedSectionModel: Equatable {
    
    static func == (lhs: FeedSectionModel, rhs: FeedSectionModel) -> Bool {
        return lhs.title == rhs.title &&
            lhs.cellModels == rhs.cellModels
    }
}

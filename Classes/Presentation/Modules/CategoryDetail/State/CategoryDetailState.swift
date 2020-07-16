//
//  Created by Kamolbek on 13/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

final class CategoryDetailState {
    
    let category: FeedCategory
    var isLoading: Bool = false
    var images: [FeedImage]?

    init(category: FeedCategory) {
        self.category = category
    }
}

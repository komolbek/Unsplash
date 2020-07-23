//
//  Created by Komolbek Ibragimov on 14/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import Foundation

struct CategoryDetails: Codable {
    
    let results: [FeedImage]?
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

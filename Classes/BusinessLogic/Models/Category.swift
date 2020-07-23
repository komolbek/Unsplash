//  Created by Komolbek Ibragimov on 10/07/2020
//  Copyright © 2020 HiQo. All rights reserved.

import Foundation

struct FeedCategory: Codable {
    
    let id: Int?
    let title: String?
    let tags: [Tag?]
    let user: User?
    let coverPhoto: CoverPhoto?
    
    enum CodingKeys: String, CodingKey {
        case id, title, tags, user
        case coverPhoto = "cover_photo"
    }
}

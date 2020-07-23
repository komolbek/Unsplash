//
//  Created by Komolbek Ibragimov on 10/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import Foundation

struct Source: Codable {
    
    let coverPhoto: CoverPhoto?

    enum CodingKeys: String, CodingKey {
        case coverPhoto = "cover_photo"
    }
}

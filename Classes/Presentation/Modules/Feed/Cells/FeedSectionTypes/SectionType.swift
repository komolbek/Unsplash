//
//  Created by Komolbek Ibragimov on 15/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import Foundation

enum SectionType: String, CaseIterable {

    case explore, new

    var title: String {
        switch self {
        case .explore:
            return "Explore"
        case .new:
            return "New"
        }
    }
}

//
//  Created by Komolbek Ibragimov on 08/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import Foundation

// MARK: - User
struct User: Codable {
    let name: String?
    let firstName: String?
  
    enum CodingKeys: String, CodingKey {
        case name
        case firstName = "first_name"
    }
}

//
//  Created by Komolbek Ibragimov on 20/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import Foundation

struct RegistrationUser: Codable {
    
    var firstName: String?
    var lastName: String?
    var userName: String?
    var email: String?
    var password: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case userName = "username"
        case email, password
    }
}

//
//  Created by Komolbek Ibragimov on 21/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import Foundation

enum RegistrationField: String, CaseIterable {
    
    case firstName, lastName, userName, email, password
    
    var title: String {
        switch self {
        case .firstName:
            return "First name"
        case .lastName:
            return "Last name"
        case .userName:
            return "User name"
        case .email:
            return "Email"
        case .password:
            return "Password"
        }
    }
}

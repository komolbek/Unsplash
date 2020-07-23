//
//  Created by Komolbek Ibragimov on 22/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import Foundation

struct RequiredPasswordError: LocalizedError {

    let name: RegistrationField
    var errorDescriptionText: String = "Please enter correct password type"
    
    init(name: RegistrationField) {
        self.name = name
    }
}

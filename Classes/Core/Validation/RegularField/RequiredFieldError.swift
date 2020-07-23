//
//  Created by Komolbek Ibragimov on 21/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import Foundation

struct RequiredFieldError: LocalizedError {

    let name: RegistrationField
    var errorDescriptionText: String = "Thid field is required"
    
    init(name: RegistrationField) {
        self.name = name
    }
}

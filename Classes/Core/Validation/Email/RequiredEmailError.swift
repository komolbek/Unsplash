//
//  Created by Komolbek Ibragimov on 22/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import Foundation

struct RequiredEmailError: LocalizedError {

    let name: RegistrationField
    var errorDescriptionText: String = "Please enter correct email format"
    
    init(name: RegistrationField) {
        self.name = name
    }
}

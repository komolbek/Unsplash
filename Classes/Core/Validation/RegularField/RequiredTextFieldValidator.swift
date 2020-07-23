//
//  Created by Komolbek Ibragimov on 21/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import Foundation

final class RequiredTextFieldValidator {
    
    let name: RegistrationField
    
    init(name: RegistrationField) {
        self.name = name
    }
    
    func validateText(_ text: String?) throws {
        if text?.isEmpty ?? false || text == nil {
            throw RequiredFieldError(name: name)
        }
    }
}

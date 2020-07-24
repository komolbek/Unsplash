//
//  Created by Komolbek Ibragimov on 22/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import Foundation

final class RequiredPasswordValidator {
    
    let name: RegistrationField
    
    init(name: RegistrationField) {
        self.name = name
    }
    
    func validate(password: String?) throws {
        let passwordRegx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@", passwordRegx)
        
        if !passwordCheck.evaluate(with: password) {
            throw RequiredPasswordError(name: name)
        }
    }
}

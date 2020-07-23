//
//  Created by Komolbek Ibragimov on 21/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import Foundation

final class RequiredEmailValidator {
    
    let name: RegistrationField
    
    init(name: RegistrationField) {
        self.name = name
    }
    
    func validate(email: String?) throws {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        
        if !emailPredicate.evaluate(with: email) {
            throw RequiredEmailError(name: name)
        }
    }
}

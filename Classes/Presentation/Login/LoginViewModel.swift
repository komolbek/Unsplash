//
//  Created by Kamolbek on 16/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

final class LoginViewModel {
    
    init(state: LoginState) {
        
    }
}

// MARK: -  Equatable

extension LoginViewModel: Equatable {
    
    static func == (lhs: LoginViewModel, rhs: LoginViewModel) -> Bool {
        return false
    }
}

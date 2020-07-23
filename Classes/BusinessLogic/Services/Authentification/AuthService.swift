//  Created by Kamolbek on 20/07/2020
//  Copyright © 2020 HiQo. All rights reserved.

import Foundation

final class AuthService: NetworkService, AuthServiceProtocol {
    
    func registerUser(user: RegistrationUser) {
        let endpoint: AuthEndpoint = .register(user: user)
        
        request(endpoint: endpoint, success: { (response: Data) in
            do {
                let result = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                print(result)
            } catch {
                print(error)
            }
        }) { error in
            print(error.localizedDescription)
        }
    }
}

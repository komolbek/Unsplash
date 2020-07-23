//
//  Created by Kamolbek on 20/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

protocol HasAuthService {
    var authService: AuthServiceProtocol { get }
}

protocol AuthServiceProtocol: class {
    func registerUser(user: RegistrationUser)
}

//
//  Created by Komolbek Ibragimov on 20/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import Foundation

enum AuthEndpoint {
    case register(user: RegistrationUser)
}

extension AuthEndpoint: Endpoint {
    
    var baseURL: URL {
        AppConfiguration.serverURL
    }
    
    var path: String {
        switch self {
        case .register:
            return "/users"
        }
    }
    
    var headers: [String: Any] {
        switch self {
        case .register:
            return ["content-type": "application/x-www-form-urlencoded",
                    "authorization": "Client-ID 9657b2982a53f8bf4b567fe7899da7354456296f0d91a2f918a1bbcfec8a021e",
                    "x-unsplash-secret": "16250fbc041984b2a9ad364253caaf9dae04ee9f93479850ed7c7d86203a5e8d",
                    "accept-language": "ru",
                    "user-agent": "Unsplash/73 CFNetwork/1126 Darwin/19.5.0",
                    "x-unsplash-id": "9657b2982a53f8bf4b567fe7899da7354456296f0d91a2f918a1bbcfec8a021e"]
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .register(let user):
            return ["firstName": user.firstName ?? "",
                    "lastName": user.lastName ?? "",
                    "userName": user.userName ?? "",
                    "email": user.email ?? "",
                    "password": user.password ?? ""]
        }
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameterEncoding: ParameterEncoding {
        return .jsonEncoding
    }
}

//  Created by Komolbek Ibragimov on 08/07/2020
//  Copyright © 2020 HiQo. All rights reserved.

import Foundation

enum PhotoEndpoint {
    case new(pageNumber: Int)
    case explore, collections
    case categotyDetails(title: String?, categoryID: Int?)
}

extension PhotoEndpoint: Endpoint {
    
    var baseURL: URL {
        AppConfiguration.serverURL
    }
    
    var path: String {
        switch self {
        case .new, .explore:
            return "photos"
        case .collections:
            return "collections"
        case .categotyDetails:
            return "search/photos"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .new(let pageNumber):
            return ["client_id": AppConfiguration.apiKey,
                    "query": "new",
                    "page": "\(pageNumber)",
                    "per_page": "30"]
        case .explore:
            return ["client_id": AppConfiguration.apiKey,
                    "query": "explore"]
        case .collections:
            return ["client_id": AppConfiguration.apiKey]
        case .categotyDetails(let title, let categoryID):
            return ["client_id": AppConfiguration.apiKey,
                    "collections": categoryID ?? 0,
                    "query": title ?? ""]
        }
    }
    
    var method: HTTPMethod {
        .get
    }

    var headers: [String : Any] {
        [:]
    }

    var parameterEncoding: ParameterEncoding {
        return .urlEndoding
    }
}

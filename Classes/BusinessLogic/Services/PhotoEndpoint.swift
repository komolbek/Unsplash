//  Created by Komolbek Ibragimov on 08/07/2020
//  Copyright © 2020 HiQo. All rights reserved.

import Foundation

enum PhotoEndpoint {
    case new, explore, collections
    case categotyDetails(title: String?, categoryID: Int?)
}

enum PathEndpoint {
    case photos , collections
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
        case .new:
            return ["client_id": AppConfiguration.apiKey,
                    "query": "new"]
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
}

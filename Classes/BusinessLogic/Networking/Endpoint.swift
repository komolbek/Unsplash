//
//  Created by Komolbek Ibragimov on 08/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import Foundation

typealias Parameters = [String: Any]

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var method: HTTPMethod { get }
}

extension Endpoint {
    var url: URL {
        baseURL.appendingPathComponent(path)
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}


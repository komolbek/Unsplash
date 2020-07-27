//  Created by Komolbek Ibragimov on 08/07/2020
//  Copyright © 2020 HiQo. All rights reserved.

import Foundation

typealias Success<T> = (T) -> Void
typealias Failure = (Error) -> Void

protocol NetworkServiceProtocol: class {
    func request<Result: Codable>(endpoint: Endpoint,
                                  success: @escaping Success<Result>,
                                  failure: @escaping Failure)
}

class NetworkService: NetworkServiceProtocol { }

extension NetworkService {
    func request<Result: Codable>(endpoint: Endpoint,
                                  success: @escaping Success<Result>,
                                  failure: @escaping Failure) {
        
        let url = endpoint.url
        let queryItems = endpoint.parameters?.compactMap({ (name, value) -> URLQueryItem? in
            return URLQueryItem(name: name, value: value as? String)
        })
        var urlComponents = URLComponents(string: url.absoluteString)
        urlComponents?.queryItems = queryItems
        
        guard let resultURL = urlComponents?.url else {
            return
        }
        
        URLSession.shared.dataTask(with: resultURL) { (data, response, error) in
            if let error = error {
                failure(error)
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let result: Result = try JSONDecoder().decode(from: data)
                success(result)
            } catch {
                failure(error)
            }
        }.resume()
    }
}

//MARK: - Helpers

enum ErrorType: Error {
    case errorOnDataFormat
    case errorOnRequest
}

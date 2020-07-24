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
        let task: URLSessionDataTask?
        switch endpoint.parameterEncoding {
        case .jsonEncoding:
            task = jsonEncodedRequest(endpoint: endpoint, success: success, failure: failure)
        case .urlEndoding:
            task = urlEncodedRequest(endpoint: endpoint, success: success, failure: failure)
        }
        task?.resume()
    }
    
    fileprivate func urlEncodedRequest<Result: Codable>(endpoint: Endpoint,
                                                        success: @escaping Success<Result>,
                                                        failure: @escaping Failure) -> URLSessionDataTask? {
        let url = endpoint.url
        let queryItems = endpoint.parameters?.compactMap { (name, value) -> URLQueryItem? in
            return URLQueryItem(name: name, value: value as? String)
        }
        var urlComponents = URLComponents(string: url.absoluteString)
        urlComponents?.queryItems = queryItems
        
        guard let resultURL = urlComponents?.url else {
            return nil
        }
        
        return URLSession.shared.dataTask(with: resultURL) { (data, response, error) in
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
        }
    }
    
    fileprivate func jsonEncodedRequest<Result: Codable>(endpoint: Endpoint,
                                                         success: @escaping Success<Result>,
                                                         failure: @escaping Failure) -> URLSessionDataTask? {
        let url = endpoint.url
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        endpoint.headers.forEach { (key, value) in
            if let value = value as? String {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: endpoint.parameters ?? [:],
                                                         options: []) else {
                                                            return nil
        }
        request.httpBody = httpBody
        
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .init())
                print(json)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

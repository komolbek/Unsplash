//
//  Created by Komolbek Ibragimov on 12/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import Foundation

public extension JSONDecoder {

    func decode<T: Decodable>(from data: Data) throws -> T {
        var description = "❌ Decoding error:\n"
        do {
            return try decode(T.self, from: data)
        } catch let decodingError as DecodingError {
            description += decodingError.description
            if let json = String(data: data, encoding: .utf8) {
                description += "\n📄 for JSON: \(json)"
            }
            throw CustomDecodingError(errorDescription: description)
        } catch {
            description += error.localizedDescription
            throw CustomDecodingError(errorDescription: description)
        }
    }
}

// MARK: -  Error

private struct CustomDecodingError: LocalizedError {
    let errorDescription: String
}

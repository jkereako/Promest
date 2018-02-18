//
//  Coder.swift
//  Pusher
//
//  Created by Jeff Kereakoglow on 2/17/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import Foundation
import Promises

final class Coder: CoderType {
    private let dispatchQueue = DispatchQueue(label: "JSONCoderQueue")

    /// Asynchronously encodes a contract to JSON data.
    ///
    /// - Parameter contract:
    /// - Returns: a Data instance of encoded JSON
    func encode<T: Encodable>(_ contract: T) -> Promise<Data> {
        return Promise<Data>(on: dispatchQueue) { fulfill, reject in
            do {
                let encoded = try JSONEncoder().encode(contract)

                fulfill(encoded)
            } catch {
                reject(error)
            }
        }
    }

    /// Asynchronously decodes JSON data into a contract
    ///
    /// - Parameters:
    ///   - data: The JSON data to decode
    ///   - to: The contract type to decode to
    /// - Returns: A contract
    func decode<T: Decodable>(_ data: Data, to: T.Type) -> Promise<T> {
        return Promise<T>(on: dispatchQueue) { fulfill, reject in
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)

                fulfill(decoded)
            } catch {
                reject(error)
            }
        }
    }
}

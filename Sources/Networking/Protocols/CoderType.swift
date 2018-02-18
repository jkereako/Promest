//
//  CoderType.swift
//  Pusher
//
//  Created by Jeff Kereakoglow on 2/17/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import Promises

protocol CoderType {
    /// Asynchronously encodes a contract to JSON data.
    ///
    /// - Parameter contract:
    /// - Returns: a Data instance of encoded JSON
    func encode<T: Encodable>(_ contract: T) -> Promise<Data>

    /// Asynchronously decodes JSON data into a contract
    ///
    /// - Parameters:
    ///   - data: The JSON data to decode
    ///   - to: The contract type to decode to
    /// - Returns: A contract
    func decode<T: Decodable>(_ data: Data, to: T.Type) -> Promise<T>
}

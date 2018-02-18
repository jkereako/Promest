//
//  Endpoint.swift
//  Pusher
//
//  Created by Jeff Kereakoglow on 2/17/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import Foundation

public protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
}

extension Endpoint {
    /// Builds a path and appends a query string
    ///
    /// - Parameter queryItems:
    /// - Returns: A valid path and properly escaped query string
    public func buildPath(_ path: String, appendingQueryItems queryItems: [URLQueryItem]) -> String {
        // Build the full URL and use it to create URL Components
        let url = baseURL.appendingPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = queryItems
        let urlString = components.string!

        let range = urlString.range(of: path)!
        let pathWithQueryItems = urlString[range.lowerBound..<urlString.endIndex]

        return String(pathWithQueryItems)
    }
}

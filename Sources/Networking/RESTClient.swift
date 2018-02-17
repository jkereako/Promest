//
//  RESTClient.swift
//  Pusher
//
//  Created by Jeff Kereakoglow on 2/16/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import Foundation
import Promises

/// Represents a request made to an API, however, any HTTP request can be made with this class.
final class RESTClient: RESTClientType {
    let urlSession: URLSession

    // Allow for dependency injection to make the class testable
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    func get<T: Decodable>(endpoint: Endpoint, decodable: T.Type) -> Promise<T> {
        let resource = Resource(
            endpoint: endpoint, httpMethod: .get, body: nil, headers: [:]
        )

        // Send the request and then attempt to decode the JSON object
        return sendRequest(resource: resource).then { (data) in
            guard let responseData = data else {
                throw NetworkError.emptyResponse
            }

            return Coder().decode(responseData, to: T.self)
        }
    }
}

// MARK: - Private helpers
private extension RESTClient {
    func sendRequest(resource: Resource) -> Promise<Data?> {
        let url = resource.endpoint.baseURL.appendingPathComponent(resource.endpoint.path)
        let request = NSMutableURLRequest(url: url)

        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = resource.body
        resource.headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }

        return Promise<Data?> { fulfill, reject in
            let task = self.urlSession.dataTask(with: request as URLRequest) { (data: Data?, response: URLResponse?, error: Error?) in

                guard let httpResponse = response as? HTTPURLResponse else {
                    reject(NetworkError.emptyResponse)
                    return
                }

                switch httpResponse.statusCode {
                // Success!
                case 200...299:
                    // `data` may be nil and this is okay if the request was a POST, PUT or DELETE.
                    // The only time when nil `data` is an error is on a GET request.
                    fulfill(data)

                // Redirection
                case 300...399:
                    break

                // Client error
                case 400...499:
                    reject(NetworkError.clientError(httpStatusCode: httpResponse.statusCode))

                // Server error
                case 500...599:
                    reject(NetworkError.serverError(httpStatusCode: httpResponse.statusCode))

                default:
                    break
                }
            }

            // Start the request
            task.resume()
        }
    }
}

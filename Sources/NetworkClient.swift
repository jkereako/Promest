//
//  NetworkClient.swift
//  Pusher
//
//  Created by Jeff Kereakoglow on 2/16/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import Foundation
import Promises

/// Represents a request made to an API, however, any HTTP request can be made with this class.
final class NetworkClient {
    let session: URLSession
    let baseURL: URL

    // Allow for dependency injection to make the class testable
    init(baseURL: URL, session: URLSession = URLSession.shared) {
        self.session = session
        self.baseURL = baseURL
    }

    func get(path: Path) {
        let resource = Resource(
            path: path, httpMethod: .get, body: nil, headers: [:]
        )

        sendRequest(resource: resource)
    }

    func post(path: Path, body: Data) {
        let resource = Resource(
            path: path, httpMethod: .post, body: body, headers: [:]
        )

        sendRequest(resource: resource)
    }
}

// MARK: - Private helpers
private extension NetworkClient {
    func sendRequest(resource: Resource) -> Promise<Data> {
        let url = baseURL.appendingPathComponent(resource.path.path)
        let request = NSMutableURLRequest(url: url)

        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = resource.body
        resource.headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }

        return Promise<Data> { fulfill, reject in
            let task = self.session.dataTask(with: request as URLRequest) { (data: Data?, response: URLResponse?, error: Error?) in

                guard let httpResponse = response as? HTTPURLResponse else {
                    reject(NetworkError.emptyResponse)
                    return
                }

                switch httpResponse.statusCode {
                // Success!
                case 200...299:
                    guard let responseData = data else {
                        reject(NetworkError.noData)
                        return
                    }

                    fulfill(responseData)

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

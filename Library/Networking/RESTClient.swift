//
//  RESTClient.swift
//  Networking
//
//  Created by Jeff Kereakoglow on 2/16/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import Foundation
import Promises

/// Represents a request made to an API, however, any HTTP request can be made with this class.
public final class RESTClient: RESTClientType {
    public let urlSession: URLSession

    fileprivate let headers: [String: String]

    // Allow for dependency injection to make the class testable
    public init(urlSession: URLSession, headers: [String: String] = [:]) {
        self.urlSession = urlSession
        self.headers = headers
    }

    public func request(httpMethod: HTTPMethod, endpoint: Endpoint) -> Promise<Void> {
        let resource = buildResourceWithEndpoint(endpoint, httpMethod: httpMethod, body: nil)

        return sendRequestIgnoringResponse(resource)
    }

    public func request(httpMethod: HTTPMethod, body: Data, endpoint: Endpoint) -> Promise<Void> {
        let resource = buildResourceWithEndpoint(endpoint, httpMethod: httpMethod, body: body)

        return sendRequestIgnoringResponse(resource)
    }

     public func request<T: Decodable>(httpMethod: HTTPMethod, endpoint: Endpoint, decodable: T.Type) -> Promise<T> {
        let resource = buildResourceWithEndpoint(endpoint, httpMethod: httpMethod, body: nil)

        // Send the request and then attempt to decode the JSON object
        return sendRequestDecodingResponse(resource, decodable: decodable.self)
    }

    public func request<T: Decodable>(httpMethod: HTTPMethod, body: Data, endpoint: Endpoint,
                               decodable: T.Type) -> Promise<T> {

        let resource = buildResourceWithEndpoint(endpoint, httpMethod: httpMethod, body: body)

        // Send the request and then attempt to decode the JSON object
        return sendRequestDecodingResponse(resource, decodable: decodable.self)
    }
}

// MARK: - Private helpers
private extension RESTClient {
    func buildResourceWithEndpoint(_ endpoint: Endpoint, httpMethod: HTTPMethod, body: Data?)
        -> Resource {
            return Resource(
                endpoint: endpoint, httpMethod: httpMethod, body: body, headers: self.headers
            )
    }
    func sendRequestIgnoringResponse(_ resource: Resource) -> Promise<Void> {
        // Implicitly cast `Promise<Data?>` to `Promise<Void>`
        return sendRequest(resource: resource).then { _ -> Void  in
            return
        }
    }

    func sendRequestDecodingResponse<T: Decodable>(_ resource: Resource,
                                                   decodable: T.Type) -> Promise<T> {
        return sendRequest(resource: resource).then { (data) in
            guard let responseData = data else {
                throw NetworkError.emptyResponse
            }

            return Coder().decode(responseData, to: T.self)
        }
    }

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
                    fulfill(data)

                // Redirection
                case 300...399:
                    // Not sure what to do here. I broke out redirection status codes in case we
                    // want to handle these separately in the future.
                    fulfill(data)

                // Client error
                case 400...499:
                    reject(NetworkError.clientError(httpStatusCode: httpResponse.statusCode))

                // Server error
                case 500...599:
                    reject(NetworkError.serverError(httpStatusCode: httpResponse.statusCode))

                default:
                    // This should never happen.
                    assertionFailure("Unexpected response code.")
                    reject(NetworkError.unknown)
                }
            }

            // Start the request
            task.resume()
        }
    }
}

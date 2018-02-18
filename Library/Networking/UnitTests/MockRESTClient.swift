//
//  MockRESTClient.swift
//  NetworkingTests
//
//  Created by Jeff Kereakoglow on 2/18/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import Promises
@testable import Networking

final class MockRESTClient: RESTClientType {
    let urlSession: URLSessionType
    let jsonData: Data
    let jsonDecoder = JSONDecoder()

    init(urlSession: URLSessionType) {
        self.urlSession = urlSession
        data = Data()
    }

    init(urlSession: URLSessionType, jsonData: Data) {
        self.urlSession = urlSession
        self.jsonData = jsonData
    }

    func request(httpMethod: HTTPMethod, endpoint: Endpoint) -> Promise<Void> {
        return Promise<Void> { return }
    }

    func request(httpMethod: HTTPMethod, body: Data, endpoint: Endpoint) -> Promise<Void> {
        return Promise<Void> { return }
    }

    func request<T>(httpMethod: HTTPMethod, endpoint: Endpoint, decodable: T.Type)
        -> Promise<T> where T : Decodable {
            
            return Promise<T> { () -> T in
                return try! self.jsonDecoder.decode(T.self, from: self.jsonData)
            }
    }

    func request<T>(httpMethod: HTTPMethod, body: Data, endpoint: Endpoint, decodable: T.Type)
        -> Promise<T> where T : Decodable {

            return Promise<T> { () -> T in
                return try! self.jsonDecoder.decode(T.self, from: self.jsonData)
            }
    }
}

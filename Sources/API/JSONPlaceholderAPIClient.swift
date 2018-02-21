//
//  JSONPlaceholderAPIClient.swift
//  Promest
//
//  Created by Jeff Kereakoglow on 2/21/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//


import Networking
import Promises

final class JSONPlaceholderAPIClient {
    let restClient: RESTClientType

    init(restClient: RESTClientType) {
        self.restClient = restClient
    }

    func get<T: Decodable>(_ endpoint: JSONPlaceholderEndpoint,
                           decodeResponseTo decodeable: T.Type) -> Promise<T> {
        return restClient.request(httpMethod: .get, endpoint: endpoint, decodable: decodeable)
    }

    func post<T: Decodable>(_ endpoint: JSONPlaceholderEndpoint,
                           decodeResponseTo decodeable: T.Type) -> Promise<T> {
        return restClient.request(httpMethod: .post, endpoint: endpoint, decodable: decodeable)
    }
}


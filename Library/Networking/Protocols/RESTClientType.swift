//
//  RESTClientType.swift
//  Networking
//
//  Created by Jeff Kereakoglow on 2/17/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import Foundation
import Promises

public protocol RESTClientType {
    var urlSession: URLSession { get }

    func request(httpMethod: HTTPMethod, endpoint: Endpoint) -> Promise<Void>
    func request(httpMethod: HTTPMethod, body: Data, endpoint: Endpoint) -> Promise<Void>
    func request<T: Decodable>(httpMethod: HTTPMethod, endpoint: Endpoint,
                               decodable: T.Type) -> Promise<T>
    func request<T: Decodable>(httpMethod: HTTPMethod, body: Data, endpoint: Endpoint,
                               decodable: T.Type) -> Promise<T>
}

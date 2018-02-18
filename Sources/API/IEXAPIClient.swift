//
//  IEXAPIClient.swift
//  Promest
//
//  Created by Jeff Kereakoglow on 2/18/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import Networking
import Promises

final class IEXAPIClient {
    let restClient: RESTClientType

    init(restClient: RESTClientType) {
        self.restClient = restClient
    }

    func get<T: Decodable>(_ endpoint: IEX, decodeResponseTo decodeable: T.Type) -> Promise<T> {
        return restClient.request(httpMethod: .get, endpoint: endpoint, decodable: decodeable)
    }
}

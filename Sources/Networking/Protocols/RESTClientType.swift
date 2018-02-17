//
//  RESTClientType.swift
//  Pusher
//
//  Created by Jeff Kereakoglow on 2/17/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import Foundation
import Promises

protocol RESTClientType {
    var urlSession: URLSession { get }

    func get<T: Decodable>(endpoint: Endpoint, decodable: T.Type) -> Promise<T>
}

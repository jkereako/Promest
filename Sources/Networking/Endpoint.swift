//
//  Endpoint.swift
//  Pusher
//
//  Created by Jeff Kereakoglow on 2/17/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import Foundation

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
}

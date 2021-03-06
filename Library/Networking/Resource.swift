//
//  Resource.swift
//  Networking
//
//  Created by Jeff Kereakoglow on 2/16/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import Foundation

struct Resource {
    let endpoint: Endpoint
    let httpMethod: HTTPMethod
    let body: Data?
    let headers: [String: String]
}

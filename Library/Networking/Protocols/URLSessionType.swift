//
//  URLSessionType.swift
//  Networking
//
//  Created by Jeff Kereakoglow on 2/18/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import Foundation

public protocol URLSessionType {
    func task(with request: URLRequest,
              completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

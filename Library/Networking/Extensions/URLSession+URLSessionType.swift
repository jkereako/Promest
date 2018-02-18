//
//  URLSession+URLSessionType.swift
//  Networking
//
//  Created by Jeff Kereakoglow on 2/18/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import Foundation

extension URLSession: URLSessionType {
    public func task(with request: URLRequest,
              completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {

        return dataTask(with: request, completionHandler: completionHandler)
    }
}

//
//  URLSession+URLSessionType.swift
//  Pusher
//
//  Created by Jeff Kereakoglow on 2/17/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import Foundation

extension URLSession: URLSessionType {
    func task(with request: URLRequest,
              completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {

        return dataTask(with: request, completionHandler: completionHandler)
    }
}

//
//  MockURLSession.swift
//  NetworkingTests
//
//  Created by Jeff Kereakoglow on 2/18/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import Foundation
@testable import Networking

final class MockURLSession: URLSessionType {
    func task(with request: URLRequest,
              completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
        -> URLSessionDataTask {

            let urlResponse = URLResponse(
                url: request.url!,
                mimeType: nil,
                expectedContentLength: 0,
                textEncodingName: nil
            )

            completionHandler(nil, urlResponse, nil)

            return URLSessionDataTask()
    }
}

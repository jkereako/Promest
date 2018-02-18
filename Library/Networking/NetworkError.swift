//
//  NetworkError.swift
//  Networking
//
//  Created by Jeff Kereakoglow on 2/16/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case noData
    case emptyResponse
    case redirection(httpStatusCode: Int)
    case clientError(httpStatusCode: Int)
    case serverError(httpStatusCode: Int)
}
